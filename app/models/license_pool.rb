class LicensePool < ApplicationRecord
  belongs_to :distributor
  belongs_to :product

  validates :distributor, presence: true
  validates :product, presence: true
  validates :feature_name, presence: true
  validates :feature_stock, numericality: { greater_than_or_equal_to: 0 }

  def display_name
    "#{distributor.company} - #{product.display_name} - #{feature_name}"
  end
end
