class CreateLicenseCommand < BaseCommand
  attribute :license, License

  validates :license, presence: true
  validate :ensure_counted_license_features_are_sufficient

  def execute
    return false unless valid?
    License.transaction do
      unless license.save
        return false
      end
      create_license_usage_for_every_counted_feature
      decrement_license_pool_for_every_counted_feature
    end
    true
  end

  private
  def ensure_counted_license_features_are_sufficient
    return unless license
    license.product.features.each do |feature_spec|
      if feature_spec['count']
        pool = LicensePool.find_by distributor: license.customer.distributor,
          product: license.product, feature_name: feature_spec['name']
        if pool
          if license.features[feature_spec['name']] > pool.feature_stock
            license.errors.add "feature.#{feature_spec['name']}", :feature_usage_must_not_exceed_the_pool_stock_size
            errors.add :license, :feature_usage_must_not_exceed_the_pool_stock_size
          end
        end
      end
    end
  end

  def create_license_usage_for_every_counted_feature
    license.features.each do |name, value|
      feature_spec = license.product.feature_by_name name
      if feature_spec['count'] && value >= 0
        current_usage = LicenseUsage.where(distributor: license.customer.distributor,
          product: license.product, feature_name: name).
          order(:created_at).last
        if current_usage
          total = current_usage.feature_total + value
        else
          total = value
        end
        LicenseUsage.create! distributor: license.customer.distributor,
          product: license.product, feature_name: name,
          feature_delta: value, feature_total: total
      end
    end
  end

  def decrement_license_pool_for_every_counted_feature
    license.features.each do |name, value|
      feature_spec = license.product.feature_by_name name
      if feature_spec['count'] && value >= 0
        pool = LicensePool.find_by distributor: license.customer.distributor,
          product: license.product, feature_name: feature_spec['name']
        if pool
          pool.update_attribute :feature_stock, pool.feature_stock - value
        end
      end
    end
  end
end
