class Address < ValueObject
  attr_accessor :street
  attr_accessor :zip_code
  attr_accessor :city
  attr_accessor :country

  def initialize street = nil, zip_code = nil, city = nil, country = nil
    @street = street
    @zip_code = zip_code
    @city = city
    @country = country
  end

  def country_name
    c = ISO3166::Country[country]
    return '' unless c
    c.translations[I18n.locale.to_s] || c.name
  end

  def short
    [zip_code, city, country_name].reject(&:blank?).join(', ')
  end

  def long
    [street, zip_code, city, country_name].reject(&:blank?).join(', ')
  end
end
