require 'rails_helper'

describe SystemHelper do
  describe '#application_version' do
    it 'should return the current applcation version' do
      expect(helper.application_version).to eq VERSION
    end
  end
end
