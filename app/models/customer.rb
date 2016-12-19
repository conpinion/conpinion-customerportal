class Customer < ApplicationRecord
  include Versionable

  composed_of :address,
    mapping: [
      %w(address_street street),
      %w(address_zip_code zip_code),
      %w(address_city city),
      %w(address_country country)]

  belongs_to :responsible, class_name: 'User'
  belongs_to :distributor
  has_many :licenses

  validates :name, presence: true
  validates :company, presence: true
  validates_uniqueness_of :company, scope: :name
  validates_associated  :address
end
