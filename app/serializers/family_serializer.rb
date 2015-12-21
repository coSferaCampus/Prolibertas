class FamilySerializer < ActiveModel::Serializer
  attributes :id, :created_by, :used_services_of_selected_day, :used_services_of_selected_day_id,
    :name, :surname, :origin, :menu, :phone, :adults, :children, :birthchildren, :socialworker,
    :type_of_income, :amount_of_income, :address, :assistance, :id_type, :identifier, :from, :to,
    :zts, :social_tlf, :muslim, :ropero_date, :ropero_time, :city
#  , :address_type
end
