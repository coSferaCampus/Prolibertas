class UsedServiceSerializer < ActiveModel::Serializer
  attributes :id, :person_id, :family_id, :service_id, :created_at
end
