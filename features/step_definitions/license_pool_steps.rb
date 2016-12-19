And(/^that distributor is granted a license pool of (\d+) for feature "([^"]*)" to that product$/) do |amount, name|
  LicensePool.create! distributor: @distributor, product: @product,
    feature_name: name, feature_stock: amount
end
