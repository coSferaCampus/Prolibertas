class Attachment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Userstamp

  mongoid_userstamp user_model: 'User'

  mount_uploader :file, FileUploader

  belongs_to :person

  validates :file, presence: true

  def file_name
    self.file.file.file.split("/").pop
  end

  def file_type
    self.file.file.file.split(".").pop
  end

  def file_url
    self.file.url
  end

end
