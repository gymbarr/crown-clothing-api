module ActiveModelSerializers
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :username, :email, :roles_name
  end
end
