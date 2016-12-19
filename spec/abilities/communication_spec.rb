require 'rails_helper'
require 'rails_helper'
require 'cancan/matchers'

describe 'Communication abilities' do
  let(:customer_user) { Fabricate :customer_user }
  let(:distributor_user) { Fabricate :distributor_user }
  let(:admin_user) { Fabricate :admin_user }
  let(:user) { nil }

  subject(:ability) { Ability.new user }

  context 'when the user is not authenticated' do
    it { is_expected.not_to be_able_to :call, :any }
  end

  context 'when the user is a customer' do
    let(:user) { Fabricate :customer_user }
    it { is_expected.not_to be_able_to :call, :any }
  end

  context 'when the user is a distributor' do
    let(:user) { Fabricate :distributor_user }
    it { is_expected.to be_able_to :call, admin_user }
    it { is_expected.not_to be_able_to :call, distributor_user }
    it { is_expected.not_to be_able_to :call, customer_user }
  end

  context 'when the user is an administrator' do
    let(:user) { Fabricate.build :admin_user }
    it { is_expected.to be_able_to :call, :any }
  end
end
