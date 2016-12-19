module StringHelper
  def sanitize_filename filename
    filename.strip.gsub(/^.*(\\|\/)/, '').gsub(/[^0-9A-Za-z.\-]/, '_')
  end
end
