# frozen_string_literal: true

class PhotosController < ApplicationController
  def destroy
    @photo = ActiveStorage::Attachment.find(params[:id])
    @photo.destroy
  end
end
