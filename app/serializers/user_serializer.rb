class UserSerializer < ActiveModel::Serializer
  attributes :id, :login, :password, :name, :avatar
end
