class UserSerializer < Panko::Serializer
  attributes :id, :username, :email, :roles_name

  delegate :roles_name, to: :object
end
