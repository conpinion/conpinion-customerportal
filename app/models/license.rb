class License < ApplicationRecord
  include Versionable

  belongs_to :product
  belongs_to :customer
  serialize :features, Hash

  validates :product, presence: true
  validates :customer, presence: true
  validates :serial_number, presence: true, uniqueness: true
  validates_uniqueness_of :machine_code, scope: [:customer, :product], if: :machine_code_present?
  validates :features, presence: true, allow_blank: true
  validate :counted_features_are_valid

  before_validation :create_serial_number_if_empty
  after_initialize :initialize_features

  def respond_to? method, _include_all = false
    method.to_s.start_with?('feature.') || super
  end

  def method_missing method, *args
    method_name = method.to_s
    super unless method_name.start_with? 'feature.'
    name = method_name.match(/feature.([^=]+)/)[1]
    if method_name.end_with? '='
      set_feature_value name, args[0]
    else
      get_feature_value name
    end
  end

  def init_feature_defaults_from_product
    product.features.each do |feature|
      if feature['default']
        features[feature['name']] = feature['default']
      else
        features[feature['name']] = case feature['type']
          when 'boolean'
            false
          when 'number'
            0
          else
            nil
        end
      end
    end
  end

  private
  def create_serial_number_if_empty
    self.serial_number = SecureRandom.uuid unless serial_number.present?
  end

  def initialize_features
    self.features ||= {}
  end

  def get_feature_value name
    features[name]
  end

  def set_feature_value name, value
    features_spec = product.feature_by_name name
    case features_spec['type']
      when 'boolean'
        self.features[name] = value == '1'
      when 'number'
        self.features[name] = value.to_i
      else
        Rails.logger.warn "invalid type #{features_spec[:type]} for feature #{name}"
    end
  end

  def counted_features_are_valid
    return unless product
    product.features.each do |feature_spec|
      if feature_spec['count'] && features[feature_spec['name']] < 0
        errors.add "feature.#{feature_spec['name']}", :feature_must_be_non_negative_for_pooled_features
      end
    end
  end

  def machine_code_present?
    machine_code.present?
  end
end
