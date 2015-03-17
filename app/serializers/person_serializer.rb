class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :surname, :origin, :genre, :phone, :assistance, :home, :family_status, :health_status, :birth, :nif, :social_services, :menu, :income, :address, :contact_family, :notes
end
