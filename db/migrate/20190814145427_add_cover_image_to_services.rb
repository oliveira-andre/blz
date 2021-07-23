# frozen_string_literal: true

class AddCoverImageToServices < ActiveRecord::Migration[5.2]
  def self.up
    add_column :services, :cover_image_id, :integer
  end

  def self.down
    remove_column :services, :cover_image_id
  end
end
