class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  before_action :find_user, except: %i[create index]
  before_action :authorize_user!, except: %i[create index]

  # GET /users
  def index
    authorize(User)

    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    authorize(User)

    @user = User.new(user_params)
    if @user.save
      token = Authorization::JsonWebTokenEncoder.call(user_id: @user.id)
      response.headers['token'] = token

      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
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
