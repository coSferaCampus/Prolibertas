class UsedService
  include Mongoid::Document
	include Mongoid::Timestamps


  

  belongs_to :person
  belongs_to :service


end
