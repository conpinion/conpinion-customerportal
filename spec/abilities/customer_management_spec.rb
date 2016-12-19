require 'rails_helper'
require 'rails_helper'
require 'cancan/matchers'

describe 'Customer management abilities' do
  let(:user) { nil }
  let(:distributor) { Fabricate :distributor }
  let(:customer) { Fabricate :customer, distributor: distributor }

  subject(:ability) { Ability.new user }

  context 'when the user is not authenticated' do
    it { is_expected.not_to be_able_to :manage, customer }
  end

  context 'when the user is a customer' do
    let(:user) { Fabricate :customer_user }
    it { is_expected.not_to be_able_to :manage, customer }
  end

  context 'when the user is a distributor' do
    let(:user) { Fabricate :distributor_user }
    let(:distributor) { Fabricate :distributor, responsible: user }
    let(:other_customer) { Fabricate :customer }
    it { is_expected.to be_able_to :modify, customer }
    it { is_expected.to be_able_to :create, Customer }
    it { is_expected.not_to be_able_to :destroy, customer }
    it { is_expected.not_to be_able_to :manage, other_customer }
  end

  context 'when the user is an administrator' do
    let(:user) { Fabricate.build :admin_user }
    it { is_expected.to be_able_to :manage, customer }
  end
end
