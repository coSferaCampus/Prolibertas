class Person
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,       		type: String
  field :surname,    		type: String
  field :origin,  		type: String
  field :genre,   		type: Symbol
  field :phone,    		type: String
  field :assistance, 		type: String
  field :home,  			type: String
  field :family_status,   type: String
  field :health_status, 	type: String
  field :birth,  			type: Date
  field :nif,    			type: String
  field :social_services, type: String
  field :menu,  			type: String
  field :income,  		type: String
  field :address,    		type: String
  field :contact_family, 	type: String
  field :notes,  			type: String

  has_many :used_services

  validates :name, presence: true
  validates :surname, presence: true
  validates :genre, inclusion: {in: [:man, :woman]}

end
