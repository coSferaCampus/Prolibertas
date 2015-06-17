class Person
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,              type: String
  field :surname,          type: String
  field :origin,              type: String
  field :genre,               type: Symbol
  field :phone,              type: String
  field :assistance,        type: Integer
  field :family_status,   type: String
  field :health_status,   type: String
  field :birth,                type: Date
  field :nif,                   type: String
  field :social_services, type: Integer
  field :menu,               type: String
  field :income,            type: String
  field :address,           type: String
  field :contact_family,  type: String
  field :notes,               type: String
  field :documentation, type: Integer
  field :address_type,    type: Integer
  field :residence,         type: Integer
  field :have_income,    type: Integer
  field :city,                  type: Symbol

  has_many :used_services
  has_many :alerts
  has_many :histories
  has_many :articles

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
    selected_day_from = date_from_formater $selected_day
    selected_day_to = date_to_formater $selected_day

    resultado = used_services.where(:created_at.gte => selected_day_from )
    .union.where(:created_at.lte => selected_day_to ).map do |used_service|
      [used_service.service.name, true]
    end
    Hash[resultado]
  end

  # Método que devolverá usos de servicio para el día en que se pida con su id
  def used_services_of_selected_day_id
    selected_day_from = date_from_formater $selected_day
    selected_day_to = date_to_formater $selected_day

    resultado = used_services.where(:created_at.gte => selected_day_from )
    .union.where(:created_at.lte => selected_day_to ).map do |used_service|
      [used_service.service.name, used_service.id.to_s]
    end
    Hash[resultado]
  end

  # Método que devuelve las alertas pendientes
  def pending_alerts
    selected_day_to = date_to_formater $selected_day
    alerts.where(:pending.gt => selected_day_to).desc(:created_at)
  end

  def date_from_formater( day )
   date_from = day.split("/").reverse.join("-")
   Time.parse(date_from + ' 00:00:00 +0200')
  end

  def date_to_formater( day )
   date_to = day.split("/").reverse.join("-")
   Time.parse(date_to + ' 23:59:59 +0200')
  end

end
