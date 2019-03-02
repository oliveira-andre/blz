class CreateBankDates < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_dates do |t|
      t.string :cpf_cnpj, null: false
      t.string :holder, null: false
      t.integer :bank_code, null: false
      t.string :agency, null: false
      t.string :account_number, null: false
      t.references :establishment, foreign_key: true

      t.timestamps
    end
  end
end
