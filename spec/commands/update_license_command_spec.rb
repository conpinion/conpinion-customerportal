require 'rails_helper'

describe UpdateLicenseCommand do
  subject { command }

  let(:command) { UpdateLicenseCommand.new params }
  let(:params) { { license: license, license_attributes: license_attributes } }
  let!(:license) { Fabricate :license, features: features, product: product }
  let(:features) { { 'user.count' => 10, 'no.count' => -1 } }
  let(:product) { Fabricate :product, features: features_spec }
  let(:features_spec) { [
    { 'name' => 'user.count', 'type' => 'number', 'count' => true },
    { 'name' => 'no.count', 'type' => 'number' }
  ] }
  let(:license_attributes) { nil }

  it { is_expected.to respond_to :license }
  it { is_expected.to respond_to :license_attributes }
  it { is_expected.to be_valid }

  describe 'if no license is specified' do
    let(:license) { nil }
    it { is_expected.not_to be_valid }
  end

  describe 'when a counted license feature is decremented' do
    let(:license_attributes) { { 'feature.user.count' => 5, 'feature.no.count' => -1 } }
    it { is_expected.not_to be_valid }
  end

  describe 'if we request more of a counted feature stock than is available' do
    let(:license_attributes) { { 'feature.user.count' => 20, 'feature.no.count' => -1 } }
    let!(:license_pool) { Fabricate :license_pool,
      distributor: license.customer.distributor, product: product, feature_name: 'user.count',
      feature_stock: 9 }
    it { is_expected.not_to be_valid }
  end

  describe '#execute' do
    let(:license_attributes) { { 'feature.user.count' => 20, 'feature.no.count' => 1 } }

    context 'when the command is valid' do
      before do
        Fabricate :license_usage, distributor: license.customer.distributor,
          product: license.product,
          feature_name: 'user.count', feature_delta: 10, feature_total: 10
      end

      it 'updates license object in the database' do
        expect { command.execute }.to change { license.reload.features['user.count'] }.by 10
      end

      context 'when the license features have changed' do
        it 'creates a new license usage object for each license feature to count' do
          command.execute
          expect(LicenseUsage.where distributor: license.customer.distributor,
            product: license.product,
            feature_name: 'user.count', feature_delta: 10, feature_total: 20).to exist
          expect(LicenseUsage.where distributor: license.customer.distributor,
            product: license.product,
            feature_name: 'no.count').not_to exist
        end
      end

      context 'when the license features have not changed' do
        let(:license_attributes) { { 'feature.user.count' => 10, 'feature.no.count' => -1 } }

        it 'does not creates a new license usage object' do
          expect { command.execute }.not_to change { LicenseUsage.count }
        end
      end

      it 'does not delete previous license usage objects' do
        command.execute
        expect(LicenseUsage.where distributor: license.customer.distributor,
          product: license.product,
          feature_name: 'user.count', feature_delta: 10, feature_total: 10).to exist
      end

      context 'when a license pool for a license feature is specified' do
        let!(:license_pool) { Fabricate :license_pool,
          distributor: license.customer.distributor, product: product, feature_name: 'user.count',
          feature_stock: 100 }
        it 'decreases counted features in the license pools' do
          command.execute
          expect(license_pool.reload.feature_stock).to eq 90
        end
      end

      it 'returns true' do
        expect(command.execute).to be_truthy
      end
    end

    context 'when the command is invalid' do
      before { command.license = nil }

      it 'does not create a new license usage objects in the database' do
        expect { command.execute }.not_to change { LicenseUsage.count }
      end

      it 'returns false' do
        expect(command.execute).to be_falsey
      end
    end
  end
end
