# frozen_string_literal: true

class PhotosController < ApplicationController
  respond_to :html, :js

  def destroy
    @photos = ActiveStorage::Attachment.find(params[:id])
    @photos.purge
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
      format.js
    end
  end
end
