class Views < ActiveRecord::Migration[5.2]
  def self.up
    create_table :views do |t|
      t.references :viewable, polymorphic: true
      t.integer :viewable_count, null: false, default: 1

      t.timestamp
    end
  end

  def self.down
    drop_table :views
  end
end
