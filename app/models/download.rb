class Download < ApplicationRecord
  belongs_to :product
  has_attached_file :file

  validates :name, presence: true, uniqueness: { scope: :product }
  validates_attachment_content_type :file,
    content_type: /\Atext\/plain|application\/zip|application\/pdf\z/
  validate :file_size_doesnt_exceed_storage_quota

  def self.total_size_of_all_downloads
    Download.all.map{|d| d.file_file_size || 0}.sum
  end

  private
  def file_size_doesnt_exceed_storage_quota
    new_total_size = Download.total_size_of_all_downloads + (file_file_size || 0)
    if new_total_size > Figaro.env.paperclip_storage_qouta.to_i
      errors.add :file, :file_size_must_not_exceed_storage_quota
    end
  end
end
