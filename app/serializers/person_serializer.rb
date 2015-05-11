class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :surname, :origin, :genre, :phone, :assistance,
  :home, :family_status, :health_status, :birth, :nif, :social_services, :menu,
  :income, :address, :contact_family, :notes, :used_services_of_today, :used_services_of_today_id, :pending_alerts
end
