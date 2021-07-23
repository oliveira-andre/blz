# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def t_status
    I18n.t("activerecord.enums.#{model_name.name.downcase}.#{status}")
  end

  def thumbnail(photo, resize = :medium, custom: nil)
    return if photo.nil?

    resizes = {
      avatar: '128x128!',
      small: '320x240!',
      medium: '640x480!',
      large: '1280x960!'
    }
    photo.variant(resize: custom || resizes[resize]).processed
  end
end
