require 'rails_helper'

describe RestoreLicenseCommand do
  subject { command }

  let(:command) { RestoreLicenseCommand.new params }
  let(:params) { { current_license: current_license, restore_license: restore_license } }
  let(:restore_license) { current_license ? current_license.versions[1].reify : nil }
  let(:current_license) { license.update!(features: current_features); license.reload }
  let(:license) { Fabricate :license, product: product, features: restore_features }
  let(:current_features) { { 'user_count' => 15, 'no_count' => 1 } }
  let(:restore_features) { { 'user_count' => 10, 'no_count' => -1 } }
  let(:product) { Fabricate :product, features: features_spec }
  let(:features_spec) { [
    { 'name' => 'user_count', 'type' => 'number', 'count' => true },
    { 'name' => 'no_count', 'type' => 'number' }
  ] }

  it { is_expected.to respond_to :current_license }
  it { is_expected.to respond_to :restore_license }
  it { is_expected.to be_valid }

  describe 'if no current license is specified' do
    let(:current_license) { nil }
    it { is_expected.not_to be_valid }
  end

  describe 'if no license to restore is specified' do
    let(:restore_license) { nil }
    it { is_expected.not_to be_valid }
  end

  describe '#execute' do
    context 'when the command is valid' do
      it 'restores the license object in the database' do
        expect { command.execute }.to change { current_license.reload.features }.
          from(current_features).to(restore_features)
      end

      it 'creates no new license usage object for each license feature to count' do
        expect { command.execute }.not_to change { LicenseUsage.count }
      end

      it 'returns true' do
        expect(command.execute).to be_truthy
      end
    end

    context 'when the command is invalid' do
      before { command.current_license = nil }

      it 'returns false' do
        expect(command.execute).to be_falsey
      end
    end
  end
end
