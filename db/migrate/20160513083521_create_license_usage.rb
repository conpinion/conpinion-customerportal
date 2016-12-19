class CreateLicenseUsage < ActiveRecord::Migration[5.0]
  def change
    create_table :license_usages do |t|
      t.references :distributor, foreign_key: true
      t.references :product, foreign_key: true
      t.string :feature_name
      t.integer :feature_total
      t.integer :feature_delta
      t.timestamps
    end

    add_index :license_usages, [:distributor_id, :feature_name],
      name: :index_license_usages_distributor_feature_name
    add_index :license_usages, [:distributor_id, :product_id, :feature_name],
      name: :index_license_usages_distributor_product_feature_name
    add_index :license_usages, :created_at
  end
end
