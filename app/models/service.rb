class Service
  include Mongoid::Document
  include Mongoid::Timestamps


  field :name,    type: String
  field :primary, type: Boolean

  has_many :used_services



  validates :name,        presence: true, uniqueness: {case_sensitive: false}
  validates :primary,     presence: true
end
