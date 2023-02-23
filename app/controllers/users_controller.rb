# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, except: %i[create index me]
  before_action :authorize_user!, except: %i[create index me]

  # GET /users
  def index
    authorize(User)

    @pagy, @users = pagy_countless(User.all)
    render json: Panko::Response.new(
      users: Panko::ArraySerializer.new(@users, each_serializer: PankoSerializers::UserSerializer),
      pagy: pagy_metadata(@pagy)
    ), status: :ok
  end

  # GET /users/{username}
  def show
    render json: PankoSerializers::UserSerializer.new.serialize(@user), status: :ok
  end

  # POST /users
  def create
    authorize(User)

    @user = User.new(user_params)
    if @user.save
      token = Authorization::JsonWebTokenEncoder.call(user_id: @user.id)
      response.headers['token'] = token

      render json: PankoSerializers::UserSerializer.new.serialize(@user), status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    if @user.update(user_params)
      render json: PankoSerializers::UserSerializer.new.serialize(@user), status: :ok
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  # GET /user/me
  def me
    authorize(User)

    return render status: :no_content unless @current_user

    render json: PankoSerializers::UserSerializer.new.serialize_to_json(@current_user), status: :ok
  end

  private

  def find_user
    @user = User.find_by!(username: params[:_username])
  end

  def user_params
    params.permit(
      :username, :email, :password, :password_confirmation
    )
  end

  def authorize_user!
    authorize(@user)
  end
end
