class PhotosController < ApplicationController

  def delete
    @photos = ActiveStorage::Attachment.find(params[:id])
    @photos.purge
    redirect_back(fallback_location: establishment_service_path(@photos))
  end

end
