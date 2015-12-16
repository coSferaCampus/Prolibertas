class FamilySerializer < ActiveModel::Serializer
  attributes :id, :created_by, :name, :surname, :origin, :menu, :phone, :adults, :children, :birthchildren, :socialworker, :type_of_income, :amount_of_income, :address, :assistance, :id_type, :identifier, :from, :to, :zts, :social_tlf, :muslim
#  , :address_type
end
