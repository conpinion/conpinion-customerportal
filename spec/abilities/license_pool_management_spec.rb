require 'rails_helper'
require 'rails_helper'
require 'cancan/matchers'

describe 'LicensePool management abilities' do
  let(:user) { nil }
  let(:distributor_user) { Fabricate :distributor_user }
  let(:distributor) { Fabricate :distributor, responsible: distributor_user }
  let(:license_pool) { Fabricate :license_pool, distributor: distributor }

  subject(:ability) { Ability.new user }

  context 'when the user is not authenticated' do
    it { is_expected.not_to be_able_to :manage, license_pool }
    it { is_expected.not_to be_able_to :create, LicensePool }
  end

  context 'when the user is a customer' do
    let(:user) { Fabricate :customer_user }
    it { is_expected.not_to be_able_to :manage, license_pool }
    it { is_expected.not_to be_able_to :create, LicensePool }
  end

  context 'when the user is a distributor user' do
    let(:user) { Fabricate :distributor_user }
    context 'who is not assigned to the license pool' do
      it { is_expected.not_to be_able_to :read, license_pool }
      it { is_expected.not_to be_able_to :modify, license_pool }
      it { is_expected.not_to be_able_to :create, LicensePool }
    end
    context 'who is assigned to the license pool' do
      let(:distributor_user) { user }
      it { is_expected.to be_able_to :read, license_pool }
      it { is_expected.not_to be_able_to :modify, license_pool }
      it { is_expected.not_to be_able_to :create, LicensePool }
    end
  end

  context 'when the user is an administrator' do
    let(:user) { Fabricate.build :admin_user }
    it { is_expected.to be_able_to :manage, license_pool }
    it { is_expected.to be_able_to :create, LicensePool }
  end
end
