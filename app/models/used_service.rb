class UsedService
  include Mongoid::Document

  field :created_at, type: Date

  belongs_to :person
  belongs_to :service
end
