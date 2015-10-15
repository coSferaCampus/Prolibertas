class History
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp

  mongoid_userstamp user_model: 'User'

  mount_uploader :file, FileUploader

  field :description, type: String
  field :liabilities, type: String
  field :time,        type: String
  field :newtime,     type: String
  field :date,        type: Date
  field :newdate,     type: Date

  belongs_to :person

  validates :description, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :person, presence: true

  def date_date
    self.date.strftime("%d/%m/%Y")
  end

  def newdate_date
    self.newdate.strftime("%d/%m/%Y")
  end
end
