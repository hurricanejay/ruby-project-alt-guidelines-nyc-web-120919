class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.string :address
      t.boolean :available 
      t.timestamps
    end
  end
end
