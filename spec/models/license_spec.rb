require 'rails_helper'

describe License do
  subject { license }

  let(:license) { Fabricate.build :license, product: product, features: features }
  let(:product) { Fabricate :product, features: features_spec }
  let(:features_spec) { [{ 'name' => 'user.count', 'count' => true }] }
  let(:features) { { 'user.count' => 10 } }
  let(:other_license) { Fabricate :license }

  it { is_expected.to respond_to :product }
  it { is_expected.to respond_to :customer }
  it { is_expected.to respond_to :serial_number }
  it { is_expected.to respond_to :machine_code }
  it { is_expected.to respond_to :valid_until }
  it { is_expected.to respond_to :features }
  it { is_expected.to be_valid }

  describe 'when no product is specified' do
    before { license.product = nil }
    it { is_expected.not_to be_valid }
  end

  describe 'when no customer is specified' do
    before { license.customer = nil }
    it { is_expected.not_to be_valid }
  end

  describe 'with an empty serial_number' do
    let(:license) { Fabricate :license, serial_number: nil }
    it 'should generate a serial number when created' do
      expect(license.serial_number).to be_present
    end
  end

  describe 'with an already existing serial number' do
    before { license.serial_number = other_license.serial_number }
    it { is_expected.not_to be_valid }
  end

  describe 'when the product is already licensed to a machine of the customer' do
    before do
      license.product = other_license.product
      license.customer = other_license.customer
      license.machine_code = other_license.machine_code
    end
    it { is_expected.not_to be_valid }
  end

  describe 'serialize features as JSON' do
    before { license.update_attribute :features, { 'user_count' => 123 } }
    it { expect(license.reload.features).to eq ({ 'user_count' => 123 }) }
  end

  describe 'when no features are specified they are initialized to {}' do
    before { license.update_attribute :features, nil }
    it { expect(license.reload.features).to eq ({}) }
  end

  describe 'when a feature is counted and its value is negative' do
    let(:features) { { 'user.count' => -1 } }
    it { is_expected.not_to be_valid }
  end
end
