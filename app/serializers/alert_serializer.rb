class AlertSerializer < ActiveModel::Serializer
  attributes :id, :type, :description, :cause, :pending
end
