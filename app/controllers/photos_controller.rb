class PhotosController < ApplicationController

  def destroy
    @photos = ActiveStorage::Attachment.find(params[:id])
    @photos.purge
  end
end
