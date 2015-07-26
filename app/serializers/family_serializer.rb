class FamilySerializer < ActiveModel::Serializer
  attributes :id, :created_by, :name, :surname, :origin, :menu, :genre, :phone, :adults, :children, :birthchildren, :center, :socialworker, :type_of_income, :amount_of_income, :address_type, :address, :assistance, :nif
end
