require 'rails_helper'
require 'rails_helper'
require 'cancan/matchers'

describe 'Distributor management abilities' do
  let(:user) { nil }
  let(:distributor_user) { Fabricate :distributor_user }
  let(:distributor) { Fabricate :distributor, responsible: distributor_user }

  subject(:ability) { Ability.new user }

  context 'when the user is not authenticated' do
    it { is_expected.not_to be_able_to :manage, distributor }
  end

  context 'when the user is a customer' do
    let(:user) { Fabricate :customer_user }
    it { is_expected.not_to be_able_to :manage, distributor }
  end

  context 'when the user is a distributor user' do
    let(:user) { Fabricate :distributor_user }
    context 'who is not responsible for the distributor' do
      it { is_expected.not_to be_able_to :read, distributor }
      it { is_expected.not_to be_able_to :modify, distributor }
    end
    context 'who is responsible for the distributor' do
      let(:distributor_user) { user }
      it { is_expected.to be_able_to :read, distributor }
      it { is_expected.not_to be_able_to :modify, distributor }
    end
  end

  context 'when the user is an administrator' do
    let(:user) { Fabricate.build :admin_user }
    it { is_expected.to be_able_to :manage, distributor }
  end
end
