class AttachmentsController < ApplicationController
  respond_to :json
  load_and_authorize_resource param_method: :attachment_params

  def show
    respond_with @attachment
  end

  def index
    @attachments = Person.find(params[:person_id]).attachments
    respond_with @attachments
  end

  def create
    @attachment = Person.find(params[:person_id]).attachments.create(attachment_params)
    respond_with @attachment
  end

  def update
    @attachment.update_attributes(attachment_params)
    respond_with @attachment
  end

  def destroy
    @attachment.remove_file!
    @attachment.file = nil
    @attachment.destroy
    respond_with @attachment
  end

  private

  def attachment_params
    params.require(:attachment).permit(:name, :file, :remove_file)
  end
end
