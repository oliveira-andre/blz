class CreateEstablishments < ActiveRecord::Migration[5.2]
  def change
    create_table :establishments do |t|
      t.string :name, null: false
      t.string :timetable, null: false
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.string :moip_account_id
      t.string :moip_access_token
      t.string :moip_refresh_token
      t.string :moip_set_password_link

      t.timestamps
    end
  end
end
