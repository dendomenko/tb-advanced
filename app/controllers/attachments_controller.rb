class AttachmentsController < ApplicationController
  before_action :set_attachment

  def destroy
    @attachment.destroy if @attachment.attachable.author? current_user
    redirect_back(fallback_location: root_path, notice: 'Successfully destroyed.')
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end
end
