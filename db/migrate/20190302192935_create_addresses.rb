class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.string :number, null: false
      t.string :neighborhood, null: false
      t.string :city, default: 'Porto Velho'
      t.string :state, default: 'RO'
      t.string :country, default: 'BRA'
      t.string :zipcode
      t.references :addressable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
