class CreateLicensePool < ActiveRecord::Migration[5.0]
  def change
    create_table :license_pools do |t|
      t.references :distributor, foreign_key: true
      t.references :product, foreign_key: true
      t.string :feature_name
      t.integer :feature_stock
    end
  end
end
