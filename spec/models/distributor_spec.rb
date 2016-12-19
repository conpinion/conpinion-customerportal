require 'rails_helper'

describe Distributor do
  let(:distributor) { Fabricate :distributor }

  subject { distributor }

  it { is_expected.to respond_to :company }
  it { is_expected.to respond_to :address_street }
  it { is_expected.to respond_to :address_zip_code }
  it { is_expected.to respond_to :address_city }
  it { is_expected.to respond_to :address_country }
  it { is_expected.to respond_to :address }
  it { is_expected.to respond_to :responsible }
  it { is_expected.to respond_to :customers }
  it { is_expected.to be_valid }

  describe 'with an empty company' do
    before { distributor.company = '' }
    it { is_expected.not_to be_valid }
  end
end
