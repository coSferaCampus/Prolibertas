class AlertSerializer < ActiveModel::Serializer
  attributes :id, :type, :description, :cause, :pending, :created_by
end
