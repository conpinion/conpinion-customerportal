require 'rails_helper'

describe LicensePool do
  subject { license_pool }

  let(:license_pool) { Fabricate :license_pool }

  it { is_expected.to respond_to :distributor }
  it { is_expected.to respond_to :product }
  it { is_expected.to respond_to :feature_name }
  it { is_expected.to respond_to :feature_stock }
  it { is_expected.to be_valid }

  describe 'when no distributor is specified' do
    before { license_pool.product = nil }
    it { is_expected.not_to be_valid }
  end

  describe 'when no product is specified' do
    before { license_pool.product = nil }
    it { is_expected.not_to be_valid }
  end

  describe 'when no feature name is specified' do
    before { license_pool.feature_name = '' }
    it { is_expected.not_to be_valid }
  end

  describe 'when feature stock is not >= 0' do
    before { license_pool.feature_stock = -1 }
    it { is_expected.not_to be_valid }
  end
end
