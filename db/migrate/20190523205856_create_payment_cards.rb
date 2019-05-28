class CreatePaymentCards < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_cards do |t|
      t.references :user, foreign_key: true
      t.string :moip_card_id, null: false
      t.string :brand, null: false
      t.string :expiration_month, null: false
      t.string :expiration_year, null: false
      t.string :number, null: false
      t.string :holder_name, null: false
      t.string :holder_cpf, null: false
      t.date :holder_birth_date, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
