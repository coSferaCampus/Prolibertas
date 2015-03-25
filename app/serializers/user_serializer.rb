class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :full_name, :email, :tlf
end
