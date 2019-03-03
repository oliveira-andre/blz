class CreateEstablishments < ActiveRecord::Migration[5.2]
  def change
    create_table :establishments do |t|
      t.string :cpf_cnpj, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :timetable, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
