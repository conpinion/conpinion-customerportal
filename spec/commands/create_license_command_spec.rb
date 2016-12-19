require 'rails_helper'

describe CreateLicenseCommand do
  subject { command }

  let(:command) { CreateLicenseCommand.new params }
  let(:params) { { license: license } }
  let(:license) { Fabricate.build :license, features: features, product: product }
  let(:features) { { 'user.count' => 10, 'no.count' => -1 } }
  let(:product) { Fabricate :product, features: features_spec }
  let(:features_spec) { [
    { 'name' => 'user.count', 'type' => 'number', 'count' => true },
    { 'name' => 'no.count', 'type' => 'number' }
  ] }

  it { is_expected.to respond_to :license }
  it { is_expected.to be_valid }

  describe 'if no license is specified' do
    let(:license) { nil }
    it { is_expected.not_to be_valid }
  end

  describe 'if we request more of a counted feature stock than is available' do
    let!(:license_pool) { Fabricate :license_pool,
      distributor: license.customer.distributor, product: product, feature_name: 'user.count',
      feature_stock: 9 }
    it { is_expected.not_to be_valid }
  end

  describe '#execute' do
    context 'when the command is valid' do
      it 'creates a new license object in the database' do
        expect { command.execute }.to change { License.count }.by 1
      end

      it 'creates a license usage object for each license feature to count' do
        command.execute
        expect(LicenseUsage.where distributor: license.customer.distributor,
          product: license.product,
          feature_name: 'user.count', feature_delta: 10, feature_total: 10).to exist
        expect(LicenseUsage.where distributor: license.customer.distributor,
          product: license.product,
          feature_name: 'no.count').not_to exist
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

      it 'does not create a license object in the database' do
        expect { command.execute }.not_to change { License.count }
      end

      it 'does not create a license usage objects in the database' do
        expect { command.execute }.not_to change { LicenseUsage.count }
      end

      it 'returns false' do
        expect(command.execute).to be_falsey
      end
    end
  end
end
