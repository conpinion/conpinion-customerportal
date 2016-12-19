class CreateDistributors < ActiveRecord::Migration[5.0]
  def change
    create_table :distributors do |t|
      t.string :company
      t.string :address_street
      t.string :address_zip_code
      t.string :address_city
      t.string :address_country
      t.references :responsible, foreign_key: true
      t.timestamps
    end
  end
end
