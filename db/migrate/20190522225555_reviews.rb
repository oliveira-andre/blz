class Reviews < ActiveRecord::Migration[5.2]
  def self.up
    create_table :reviews do |t|
      t.text :body, null: false
      t.references :reviewable, polymorphic: true
      t.integer :rating, null: false, default: 0
      t.references :user, foreign_key: true

      t.timestamp
    end
  end

  def self.down
    drop_table :reviews
  end
end
