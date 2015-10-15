class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :type, :amount, :requested, :dispensed, :observations, :created_by, :requested_date, :dispensed_date
end
