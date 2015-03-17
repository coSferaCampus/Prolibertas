class Service
  include Mongoid::Document
  include Mongoid::Timestamps

  # Constants
  VALID_TYPES = [
    :primary, :secondary
  ]

  field :name,    type: String
  field :type,    type: Symbol

  validates :name,        presence: true, uniqueness: {case_sensitive: false}
  validates :type,        inclusion: { in: VALID_TYPES }
end
