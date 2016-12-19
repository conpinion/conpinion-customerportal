require 'rails_helper'

describe NavigationHelper do
  describe '#awesome_link_to' do
    it 'should create an awesome link with text' do
      expect(helper.awesome_link_to 'text', 'icon', 'to')
        .to eq '<a title="text" href="to"><i class="fa fa-icon"></i><span>text</span></a>'
    end

    it 'should create an awesome link' do
      expect(helper.awesome_link_to('text', 'icon', 'to', hide_text: true))
        .to eq '<a title="text" href="to"><i class="fa fa-icon"></i></a>'
    end
  end
end
