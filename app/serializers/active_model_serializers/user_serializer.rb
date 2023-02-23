# frozen_string_literal: true

module ActiveModelSerializers
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :username, :email, :roles_name
  end
end
