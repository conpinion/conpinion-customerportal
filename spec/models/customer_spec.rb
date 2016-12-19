require 'rails_helper'

describe Customer do
  let(:customer) { Fabricate :customer }

  subject { customer }

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :company }
  it { is_expected.to respond_to :address_street }
  it { is_expected.to respond_to :address_zip_code }
  it { is_expected.to respond_to :address_city }
  it { is_expected.to respond_to :address_country }
  it { is_expected.to respond_to :address }
  it { is_expected.to respond_to :distributor }
  it { is_expected.to respond_to :responsible }
  it { is_expected.to respond_to :licenses }
  it { is_expected.to be_valid }

  describe 'with an empty name' do
    before { customer.name = '' }
    it { is_expected.not_to be_valid }
  end

  describe 'with an empty company' do
    before { customer.company = '' }
    it { is_expected.not_to be_valid }
  end

  describe 'has the same name and company as another customer' do
    let(:other_customer) { Fabricate :customer }
    before do
      customer.update_attribute :name, other_customer.name
      customer.update_attribute :company, other_customer.company
    end
    it { is_expected.not_to be_valid }
  end
end
