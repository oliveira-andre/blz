class AddSelfEmployedToEstablishment < ActiveRecord::Migration[5.2]
  def change
    add_column :establishments, :self_employed, :boolean, default: true
  end
end
