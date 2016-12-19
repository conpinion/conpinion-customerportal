Given /^there are (?:only )?(\d+) bytes of file storage available$/ do |storage_size|
  allow(Figaro.env).to receive(:paperclip_storage_qouta).and_return storage_size
end
