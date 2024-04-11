class AddPriceToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :price, :integer
  end
end
