class LicenseUsage < ApplicationRecord
  belongs_to :distributor
  belongs_to :product

  validates :distributor, presence: true
  validates :product, presence: true
  validates :feature_name, presence: true
  validates :feature_delta, numericality: { greater_than_or_equal_to: 0 }
  validates :feature_total, numericality: { greater_than_or_equal_to: 0 }
end
