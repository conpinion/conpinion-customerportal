class Product < ApplicationRecord
  serialize :features, Array
  attr_accessor :features_json
  has_and_belongs_to_many :distributors
  has_many :downloads

  validates :name, presence: true
  validates :version, presence: true
  validates_uniqueness_of :version, scope: :name
  validates :features, presence: true, allow_blank: true
  validate :features_json_is_valid_json

  after_initialize :initialize_features
  before_save :parse_features_json

  def display_name
    "#{name} #{version}"
  end

  def to_s
    display_name
  end

  def feature_names
    features.map { |f| "feature.#{f['name']}" }
  end

  def feature_by_name name
    features.select{|f| f['name'] == name}[0]
  end

  private
  def initialize_features
    self.features ||= {}
    self.features_json = "#{JSON.pretty_generate(features)}\n"
    @features_json_old = features_json
  end

  def parse_features_json
    if JSON.parse(features_json) != JSON.parse(@features_json_old)
      self.features = JSON.parse features_json
    end
  end

  def features_json_is_valid_json
    JSON.parse(features_json) rescue errors.add :features, :must_be_valid_json
  end
end
