require 'rails_helper'

describe Download do
  let(:download) { Fabricate :download }

  subject { download }

  it { expect(Download).to respond_to :total_size_of_all_downloads }

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :description }
  it { is_expected.to respond_to :file }
  it { is_expected.to be_valid }

  describe 'with an name' do
    before { download.name = '' }
    it { is_expected.not_to be_valid }
  end

  describe 'has the same name as another download of the same product' do
    let(:other_download) { Fabricate :download }
    before do
      download.product = other_download.product
      download.name = other_download.name
    end
    it { is_expected.not_to be_valid }
  end

  describe 'has the same name as another download of another product' do
    let(:other_download) { Fabricate :download }
    before do
      download.name = other_download.name
    end
    it { is_expected.to be_valid }
  end

  describe 'its file size will exceed the amount of available storage space' do
    before do
      allow(Figaro.env).to receive(:paperclip_storage_qouta).and_return 99
      allow(download).to receive(:file_file_size).and_return 100
    end
    it { is_expected.not_to be_valid }
  end

  describe '::total_size_of_all_downloads' do
    let!(:download1) { Fabricate :download, file_file_size: 100 }
    let!(:download2) { Fabricate :download, file_file_size: 200 }
    it { expect(Download.total_size_of_all_downloads).to eq 300 }
  end
end
