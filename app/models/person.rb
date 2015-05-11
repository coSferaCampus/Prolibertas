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
  has_many :alerts
  has_many :histories

  validates :name, presence: true
  validates :surname, presence: true
  validates :genre, inclusion: {in: [:man, :woman]}

  # Método que devolverá usos de servicio para el día en que se pida
  def used_services_of_today
    resultado = used_services.where(:created_at.gte => Date.today).map do |used_service|
      [used_service.service.name, true]
    end
    Hash[resultado]
  end

  # Método que devolverá usos de servicio para el día en que se pida con su id
  def used_services_of_today_id
    resultado = used_services.where(:created_at.gte => Date.today).map do |used_service|
      [used_service.service.name, used_service.id.to_s]
    end
    Hash[resultado]
  end

  # Método que devuelve las alertas pendientes
  def pending_alerts
    alerts.where(:pending.gt => Date.today).desc(:created_at)
  end

end
