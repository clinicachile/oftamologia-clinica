class CreatePacients < ActiveRecord::Migration[7.1]
  def change
    create_table :pacients do |t|
      t.string :first_name
      t.string :last_name
      t.string :run
      t.integer :age
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
