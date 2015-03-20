class Service
  include Mongoid::Document
  include Mongoid::Timestamps

  # Constants
  VALID_TYPES = [
    :primary, :secondary
  ]

  field :name,    type: String
  field :type,    type: Symbol

  has_many :used_services



  validates :name,        presence: true, uniqueness: {case_sensitive: false}
  validates :type,        inclusion: { in: VALID_TYPES }
end
