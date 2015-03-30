class HistorySerializer < ActiveModel::Serializer
  attributes :id, :description, :liabilities, :date, :time, :newdate, :newtime
end
