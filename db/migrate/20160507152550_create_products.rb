class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :version
      t.text :features
      t.timestamps
    end
  end
end
