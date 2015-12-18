class Family
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp

  mongoid_userstamp user_model: 'User'

  field :name,             type: String
  field :surname,          type: String
  field :origin,           type: String
  field :menu,             type: String # Ahora representa el campo alergias
  field :phone,            type: String
  field :birthchildren,    type: String
  field :socialworker,     type: String
  field :address,          type: String
  field :amount_of_income, type: String
  field :id_type,          type: String
  field :identifier,       type: String
  field :zts,              type: String
  field :social_tlf,       type: String
  field :ropero_time,      type: String
  field :adults,           type: Integer
  field :children,         type: Integer
  field :assistance,       type: Integer
#  field :address_type,     type: Integer
  field :type_of_income,   type: Integer
  field :from,             type: Date
  field :to,               type: Date
  field :ropero_date,      type: Date
  field :muslim,           type: Boolean, default: false

  has_many :used_services
  has_many :alerts

  validates :name,         presence: true
  validates :surname,      presence: true
  validates :adults,       presence: true
  validates :children,     presence: true
  validates :origin,       presence: true

  validates_uniqueness_of :identifier, case_sensitive: false
  validates :identifier,  format: { with: /\w*/ }

  # Método que devolverá usos de servicio para el día en que se pida
  def used_services_of_selected_day

    resultado = used_services.where(:created_at => $selected_day ).map do |used_service|
      [used_service.service.name, true]
    end
    Hash[resultado]
  end

  # Método que devolverá usos de servicio para el día en que se pida con su id
  def used_services_of_selected_day_id

    resultado = used_services.where(:created_at => $selected_day ).map do |used_service|
      [used_service.service.name, used_service.id.to_s]
    end
    Hash[resultado]
  end

  # Método que devuelve las alertas pendientes
  def pending_alerts
    alerts.where(:pending.gt => Date.today).desc(:created_at)
  end
end
