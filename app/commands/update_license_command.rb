class UpdateLicenseCommand < BaseCommand
  attribute :license, License
  attribute :license_attributes, Hash

  validates :license, presence: true
  validate :ensure_counted_license_features_are_monotonically_increasing
  validate :ensure_counted_license_features_are_sufficient

  def execute
    return false unless valid?
    License.transaction do
      unless license.update_attributes license_attributes
        return false
      end
      create_license_usage_for_every_counted_feature
      decrement_license_pool_for_every_counted_feature
    end
    true
  end

  private
  def ensure_counted_license_features_are_monotonically_increasing
    return unless license
    return unless license_attributes
    license.product.features.each do |feature_spec|
      if feature_spec['count']
        old_count = license.features[feature_spec['name']]
        new_count = license_attributes["feature.#{feature_spec['name']}"].to_i
        if new_count < old_count
          license.errors.add "feature.#{feature_spec['name']}", :feature_must_be_monotonically_increasing_for_pooled_features
          errors.add :license_attributes, :feature_must_be_monotonically_increasing_for_pooled_features
        end
      end
    end
  end

  def ensure_counted_license_features_are_sufficient
    return unless license
    return unless license_attributes
    license.product.features.each do |feature_spec|
      if feature_spec['count']
        pool = LicensePool.find_by distributor: license.customer.distributor,
          product: license.product, feature_name: feature_spec['name']
        if pool
          old_count = license.features[feature_spec['name']]
          new_count = license_attributes["feature.#{feature_spec['name']}"].to_i
          if (new_count - old_count) > pool.feature_stock
            license.errors.add "feature.#{feature_spec['name']}", :feature_usage_must_not_exceed_the_pool_stock_size
            errors.add :license, :feature_usage_must_not_exceed_the_pool_stock_size
          end
        end
      end
    end
  end

  def create_license_usage_for_every_counted_feature
    features_old, features_new = license.previous_changes['features'] || [{}, {}]
    license.features.each do |name, value|
      spec = license.product.feature_by_name name
      if spec['count'] && value > 0 && features_old[name] != features_new[name]
        current_usage = LicenseUsage.where(distributor: license.customer.distributor,
          product: license.product, feature_name: name).
          order(:created_at).last
        delta = features_new[name] - features_old[name]
        if delta > 0
          if current_usage
            total = current_usage.feature_total + delta
          else
            total = delta
          end
          LicenseUsage.create! distributor: license.customer.distributor,
            product: license.product, feature_name: name,
            feature_delta: delta, feature_total: total
        end
      end
    end
  end

  def decrement_license_pool_for_every_counted_feature
    features_old, features_new = license.previous_changes['features'] || [{}, {}]
    license.features.each do |name, value|
      feature_spec = license.product.feature_by_name name
      if feature_spec['count'] && value >= 0
        pool = LicensePool.find_by distributor: license.customer.distributor,
          product: license.product, feature_name: feature_spec['name']
        if pool
          pool.update_attribute :feature_stock,
            pool.feature_stock - (features_new[feature_spec['name']] - features_old[feature_spec['name']])
        end
      end
    end
  end
end
