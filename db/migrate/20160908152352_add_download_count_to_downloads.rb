class AddDownloadCountToDownloads < ActiveRecord::Migration[5.0]
  def change
    add_column :downloads, :download_count, :integer, default: 0
  end
end
