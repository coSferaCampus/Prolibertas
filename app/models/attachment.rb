class Attachment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp

  mongoid_userstamp user_model: 'User'

  field :name, type: String

  mount_uploader :file, FileUploader

  belongs_to :person

  validates :name, presence: true

  def file_url
    self.file.url
  end

end
