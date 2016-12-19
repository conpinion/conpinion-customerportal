require 'rails_helper'
require 'rails_helper'
require 'cancan/matchers'

describe 'Product management abilities' do
  let(:user) { nil }
  let(:product) { Fabricate :product }
  let(:distributor) { Fabricate :distributor, responsible: user }

  subject(:ability) { Ability.new user }

  context 'when the user is not authenticated' do
    it { is_expected.not_to be_able_to :manage, product }
  end

  context 'when the user is a customer user' do
    let(:user) { Fabricate :customer_user }
    it { is_expected.not_to be_able_to :manage, product }
  end

  context 'when the user is a distributor user' do
    let(:user) { Fabricate :distributor_user }
    context 'whos distributor has this product assigned' do
      before { distributor.products << product }
      it { is_expected.to be_able_to :read, product }
      it { is_expected.not_to be_able_to :modify, product }
    end
    context 'whos distributor has this product not assigned' do
      it { is_expected.not_to be_able_to :read, product }
      it { is_expected.not_to be_able_to :modify, product }
    end
  end

  context 'when the user is an administrator user' do
    let(:user) { Fabricate.build :admin_user }
    it { is_expected.to be_able_to :manage, product }
  end
end
