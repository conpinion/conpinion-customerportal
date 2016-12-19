class CreateDistributorsProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :distributors_products do |t|
      t.references :distributor, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end
