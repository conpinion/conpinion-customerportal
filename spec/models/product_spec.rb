require 'rails_helper'

describe Product do
  let(:product) { Fabricate :product }

  subject { product }

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :version }
  it { is_expected.to respond_to :features }
  it { is_expected.to respond_to :downloads }
  it { is_expected.to be_valid }

  describe 'with an empty name' do
    before { product.name = '' }
    it { is_expected.not_to be_valid }
  end

  describe 'with an empty version' do
    before { product.version = '' }
    it { is_expected.not_to be_valid }
  end

  describe 'has the same name and version as another product' do
    let(:other_product) { Fabricate :product }
    before { product.update_attribute :name, other_product.name }
    it { is_expected.not_to be_valid }
  end

  describe 'serialize features as JSON' do
    before { product.update_attribute :features, [{ 'user_count' => { 'type' => 'number' } }] }
    it { expect(product.reload.features).to eq [{ 'user_count' => { 'type' => 'number' } }] }
  end

  describe 'when no features are specified they are initialized to {}' do
    before { product.update_attribute :features, nil }
    it { expect(product.reload.features).to eq [] }
  end
end
