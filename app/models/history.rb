class History
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp
  
  mount_uploader :file, FileUploader

  field :description, type: String
  field :liabilities, type: String
  field :date,        type: Date
  field :time,        type: String
  field :newdate,     type: Date
  field :newtime,     type: String

  belongs_to :person

  validates :description, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :person, presence: true

end