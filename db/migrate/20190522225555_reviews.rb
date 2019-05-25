class Reviews < ActiveRecord::Migration[5.2]
  def self.up
    create_table :reviews do |t|
      t.text :body
      t.references :reviewable, polymorphic: true
      t.decimal :rating
      t.references :user, foreign_key: true

      t.timestamp
    end
  end

  def self.down
    drop_table :reviews
  end
end
