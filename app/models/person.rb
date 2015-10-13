class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp
  include Mongoid::NormalizeStrings

  mongoid_userstamp user_model: 'User'

  field :name,            type: String
  field :surname,         type: String
  field :origin,          type: String
  field :phone,           type: String
  field :menu,            type: String
  field :income,          type: String
  field :address,         type: String
  field :contact_family,  type: String
  field :notes,           type: String
  field :identifier,      type: String
  field :family_status,   type: String
  field :health_status,   type: String
  field :nif,             type: String
  field :assistance,      type: Integer
  field :social_services, type: Integer
  field :documentation,   type: Integer
  field :address_type,    type: Integer
  field :residence,       type: Integer
  field :have_income,     type: Integer
  field :genre,           type: Symbol
  field :city,            type: String
  field :birth,           type: Date

  normalize :origin
  normalize :city

  has_many :used_services
  has_many :alerts
  has_many :histories
  has_many :articles
  has_many :attachments

  validates :name, presence: true
  validates :surname, presence: true
  validates :origin, presence: true
  validates :genre, inclusion: { in: [:man, :woman] }

  def is_spanish
    if (self.origin != nil)
      if (self.origin.downcase == "españa" || self.origin.upcase == "ESPAÑA")
        return true
      else
        return false
      end
    end
  end

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
    alerts.where(:pending.gte => $selected_day).desc(:created_at)
  end

end
