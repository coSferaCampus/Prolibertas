class HistorySerializer < ActiveModel::Serializer
  attributes :id, :description, :liabilities, :date, :time, :newdate, :newtime, :created_by, :date_date, :newdate_date
end
