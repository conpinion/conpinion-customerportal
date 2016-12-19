require 'rails_helper'

describe LicenseUsage do
  let(:license_usage) { Fabricate :license_usage }

  subject { license_usage }

  it { is_expected.to respond_to :distributor }
  it { is_expected.to respond_to :product }
  it { is_expected.to respond_to :feature_name }
  it { is_expected.to respond_to :feature_total }
  it { is_expected.to respond_to :feature_delta }
  it { is_expected.to respond_to :created_at }
  it { is_expected.to be_valid }

  describe 'when no distributor is specified' do
    before { license_usage.product = nil }
    it { is_expected.not_to be_valid }
  end

  describe 'when no product is specified' do
    before { license_usage.product = nil }
    it { is_expected.not_to be_valid }
  end

  describe 'when no feature name is specified' do
    before { license_usage.feature_name = '' }
    it { is_expected.not_to be_valid }
  end

  describe 'when feature delta is not >= 0' do
    before { license_usage.feature_delta = -1 }
    it { is_expected.not_to be_valid }
  end

  describe 'when feature total is not >= 0' do
    before { license_usage.feature_total = -1 }
    it { is_expected.not_to be_valid }
  end
end
