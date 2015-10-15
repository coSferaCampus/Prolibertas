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

  belongs_to :person

  validates :type, inclusion: { in: [ :blanket, :sheet, :jacket, :shoes, :basket, :others1, :others2, :others3 ] }
  validates :amount, presence: true
  validates :requested, presence: true
  validates :person, presence: true

  def requested_date
    self.requested.strftime("%d/%m/%Y")
  end

  def dispensed_date
    self.dispensed.strftime("%d/%m/%Y")
  end
end
