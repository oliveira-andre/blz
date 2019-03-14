class CreateProfessionalServices < ActiveRecord::Migration[5.2]
  def change
    create_table :professional_services do |t|
      t.references :professional, foreign_key: true
      t.references :service, foreign_key: true

      t.timestamps
    end
  end
end
