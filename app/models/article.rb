class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp

  mongoid_userstamp user_model: 'User'

  field :type,      type: Symbol
  field :amount,   type: Integer
  field :requested,   type: Date
  field :dispensed,       type: Date
  field :observations,    type: String

  belongs_to :person

  validates :type, inclusion: { in: [ :blanket, :sheet, :jacket, :shoes, :others1, :others2, :others3 ] }
  validates :amount, presence: true
  validates :requested, presence: true
  validates :person, presence: true
end
