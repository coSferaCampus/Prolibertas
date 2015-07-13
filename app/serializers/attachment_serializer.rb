class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :file_name, :file_type, :file_url
end
