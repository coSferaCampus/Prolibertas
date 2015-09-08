class Family
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp

  mongoid_userstamp user_model: 'User'

  field :name,             type: String
  field :surname,          type: String
  field :origin,           type: String
  field :menu,             type: String
  field :phone,            type: String
  field :birthchildren,    type: String
  field :center,           type: String
  field :socialworker,     type: String
  field :address,          type: String
  field :nif,              type: String
  field :identifier,       type: String
  field :adults,           type: Integer
  field :children,         type: Integer
  field :assistance,       type: Integer
  field :address_type,     type: Integer
  field :type_of_income,   type: Integer
  field :amount_of_income, type: String

  has_many :used_services
  has_many :alerts

  validates :name,         presence: true
  validates :surname,      presence: true
  validates :adults,       presence: true
  validates :children,     presence: true
  validates :center,       presence: true

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
