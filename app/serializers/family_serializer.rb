class FamilySerializer < ActiveModel::Serializer
  attributes :id, :name, :surname, :origin, :menu, :genre, :phone, :adults, :children, :center, :socialworker, :type_of_income, :amount_of_income, :address_type, :address, :assistance, :nif
end
