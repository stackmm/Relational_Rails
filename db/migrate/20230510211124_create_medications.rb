class CreateMedications < ActiveRecord::Migration[7.0]
  def change
    create_table :medications do |t|
      t.string :name
      t.string :strength
      t.string :dosage_form
      t.integer :quantity
      t.boolean :in_stock
      t.references :pharmacy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
