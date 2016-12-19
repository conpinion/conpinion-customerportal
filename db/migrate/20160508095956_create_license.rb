class CreateLicense < ActiveRecord::Migration[5.0]
  def change
    create_table :licenses do |t|
      t.references :product, foreign_key: true
      t.references :customer, foreign_key: true
      t.string :serial_number
      t.string :machine_code
      t.date :valid_until
      t.text :features
      t.timestamps
    end
  end
end
