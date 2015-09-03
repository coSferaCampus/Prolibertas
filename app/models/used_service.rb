class UsedService
  include Mongoid::Document
  include Mongoid::Userstamp

  mongoid_userstamp user_model: 'User'

  field :created_at, type: Date

  belongs_to :person
  belongs_to :service
end
