class CreateOfficeHours < ActiveRecord::Migration[5.2]
  def change
    create_table :office_hours do |t|
      t.integer :hour_begin
      t.integer :hour_end
      t.references :service, foreign_key: true
      t.integer :week_day

      t.timestamps
    end
  end
end
