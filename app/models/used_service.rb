class UsedService
  include Mongoid::Document
  include Mongoid::Userstamp
  include Mongoid::Timestamps

  mongoid_userstamp user_model: 'User'

  field :created_at, type: Date

  belongs_to :person
  belongs_to :family
  belongs_to :service
end
