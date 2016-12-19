class CreateDownloads < ActiveRecord::Migration[5.0]
  def up
    create_table :downloads do |t|
      t.references :product, foreign_key: true
      t.string :name
      t.string :description
    end
    add_attachment :downloads, :file
  end

  def down
    drop_table :downloads
  end
end
