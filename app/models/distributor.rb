class Distributor < ApplicationRecord
  composed_of :address,
    mapping: [
      %w(address_street street),
      %w(address_zip_code zip_code),
      %w(address_city city),
      %w(address_country country)]

  belongs_to :responsible, class_name: 'User'
  has_many :customers
  has_and_belongs_to_many :products

  validates :company, presence: true
  validates_associated :address

  def display_name
    [company, address.short].reject(&:blank?).join(', ')
  end
end
