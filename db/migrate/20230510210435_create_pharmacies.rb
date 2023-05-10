class CreatePharmacies < ActiveRecord::Migration[7.0]
  def change
    create_table :pharmacies do |t|
      t.string :name
      t.string :pharmacist_in_charge
      t.integer :num_employees
      t.string :city
      t.boolean :open_24_hours

      t.timestamps
    end
  end
end
