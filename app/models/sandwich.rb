class Sandwich
  include Mongoid::Document
  include Mongoid::Timestamps

  field :created_at, type: Date
  field :amount, type: Integer

  validates :created_at, presence: true
  validates :amount, presence: true
end
