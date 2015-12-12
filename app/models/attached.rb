class Attached
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp

  mongoid_userstamp user_model: 'User'

  field :name, type: String
  field :description, type: String
  field :date,        type: Date

  belongs_to :person

  validates :name,        presence: true
  validates :description, presence: true
  validates :date,        presence: true
  validates :person,      presence: true

end
