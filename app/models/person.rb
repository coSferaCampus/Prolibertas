class Person
  include Mongoid::Document
  include Mongoid::NormalizeStrings
  include Mongoid::Timestamps
  include Mongoid::Userstamp

  mongoid_userstamp user_model: 'User'

  field :name,            type: String
  field :surname,         type: String
  field :origin,          type: String
  field :city,            type: String
  field :phone,           type: String
  field :menu,            type: String # Ahora representa el campo alergias
  field :income,          type: String
  field :address,         type: String
  field :contact_family,  type: String
  field :notes,           type: String
  field :family_status,   type: String
  field :health_status,   type: String
  field :id_type,         type: String
  field :identifier,      type: String
  field :exp,             type: String
  field :zts,             type: String
  field :assistance,      type: Integer
  field :social_services, type: Integer
  field :documentation,   type: Integer
  field :address_type,    type: Integer
  field :residence,       type: Integer
  field :have_income,     type: Integer
  field :genre,           type: Symbol
  field :birth,           type: Date
  field :entry,           type: Date
  field :output,          type: Date
  field :muslim,          type: Boolean, default: false

  normalize :surname
  normalize :origin
  normalize :identifier

  has_many :used_services
  has_many :alerts
  has_many :histories
  has_many :articles
  has_many :attachments

  validates :name,        presence: true
  validates :surname,     presence: true
  validates :origin,      presence: true

  validates :genre,       inclusion: { in: [:man, :woman] }

  validates_uniqueness_of :identifier, case_sensitive: false
  validates :identifier,  format: { with: /\w*/ }

  after_create do |document|
    set(exp: "%05d" % Person.all.size)
  end

  def total_people
    $total_people
  end

  def max_pages
    ($total_people / 30.0).ceil
  end

  def is_spanish
    if (self.origin != nil)
      if (self.origin.downcase == "españa" || self.origin.upcase == "ESPAÑA")
        return true
      else
        return false
      end
    end
  end

  def has_blanket
    return true if (Article.where(person_id: id, type: :blanket, :amount.gte => 1,:dispensed.gte => 15.days.ago).size >= 1)
  end

  def has_sheet
    return true if (Article.where(person_id: id, type: :sheet, :amount.gte => 1,:dispensed.gte => 15.days.ago).size >= 1)
  end

  def has_jacket
    return true if (Article.where(person_id: id, type: :jacket, :amount.gte => 1,:dispensed.gte => 15.days.ago).size >= 1)
  end

  def has_shoes
    return true if (Article.where(person_id: id, type: :shoes, :amount.gte => 1,:dispensed.gte => 15.days.ago).size >= 1)
  end

  def has_basket
    return true if (Article.where(person_id: id, type: :basket, :amount.gte => 1,:dispensed.gte => 15.days.ago).size >= 1)
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
