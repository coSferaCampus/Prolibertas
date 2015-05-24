class Alert
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp

  mongoid_userstamp user_model: 'User'

  field :type,   		type: Symbol
  field :description,   type: String
  field :cause, 	type: String
  field :pending,  			type: Date

  belongs_to :person

  validates :type, inclusion: {in: [:punishment, :warning, :advice]}
  validates :pending, presence: true
  validates :person, presence: true

end