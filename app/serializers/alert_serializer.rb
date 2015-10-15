class AlertSerializer < ActiveModel::Serializer
  attributes :id, :type, :description, :cause, :pending, :pending_date, :created_by
end
