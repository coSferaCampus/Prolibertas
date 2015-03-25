class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Roles
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :trackable

  ## Database authenticatable
  field :name,                type: String, default: ""
  field :encrypted_password,  type: String, default: ""


  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,       type: Integer, default: 0
  field :current_sign_in_at,  type: Time
  field :last_sign_in_at,     type: Time
  field :current_sign_in_ip,  type: String
  field :last_sign_in_ip,     type: String

  # Custom fields
  field :full_name,           type: String, default: ""
  field :email,               type: String, default: ""
  field :tlf,                 type: String, default: ""

  # Validations
  validates :name,            presence: true
  validates :full_name,       presence: true
  validates_presence_of       :password, on: :create
  validates :password,        confirmation: true
end
