class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp

  mongoid_userstamp user_model: 'User'

  field :observations, type: String
  field :amount,       type: Integer
  field :type,         type: Symbol
  field :requested,    type: Date
  field :dispensed,    type: Date
  field :active,       type: Date

  belongs_to :person

  validates :amount,    presence: true
  validates :requested, presence: true
  validates :dispensed, presence: true
  validates :person,    presence: true

  validates :type,      inclusion: { in: [ :blanket, :sheet, :jacket, :shoes, :basket ] }
end
