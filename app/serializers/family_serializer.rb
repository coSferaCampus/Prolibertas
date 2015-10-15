class FamilySerializer < ActiveModel::Serializer
  attributes :id, :from_date, :to_date, :created_by, :name, :surname, :origin, :menu, :phone, :adults, :children, :birthchildren, :center, :socialworker, :type_of_income, :amount_of_income, :address_type, :address, :assistance, :nif, :identifier, :from, :to
end
