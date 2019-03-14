class CreateLinkedServices < ActiveRecord::Migration[5.2]
  def change
    create_table :linked_services do |t|
      t.references :service, foreign_key: true
      t.bigint :linked_id, index: true

      t.timestamps
    end

    add_foreign_key :linked_services, :services, column: :linked_id
  end
end
