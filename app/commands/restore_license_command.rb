class RestoreLicenseCommand < BaseCommand
  attribute :current_license, License
  attribute :restore_license, License

  validates :current_license, presence: true
  validates :restore_license, presence: true

  def execute
    return false unless valid?
    License.transaction do
      unless restore_license.save
        return false
      end
      restore_license.features.each do |name, value|
        spec = restore_license.product.feature_by_name name
        if spec['count'] && current_license.features[name] != restore_license.features[name]
          # Currently doesn't update the license usage
        end
      end
    end
    true
  end
end
