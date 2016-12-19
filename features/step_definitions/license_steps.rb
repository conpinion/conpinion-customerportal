Given /^this license for this product to that customer:$/ do |table|
  step 'the following license:', table
  @license.update_attributes customer: @customer, product: @product
end

Given /^that product has a ([^ ]*) feature with name "([^"]*)"$/ do |type, name|
  @product.features << { 'name' => name, 'type' => type }
  @product.save!
end

Given /^that license should have the following features:$/ do |table|
  stringified_license_features = @license.features.reduce({}) { |h, (k, v)| h[k] = v.to_s; h }
  expect(stringified_license_features).to eq table.rows_hash
end

Given /^that product is assigned to my distributor$/ do
  @distributor.products << @product
end

Given /^that license was updated at (.+)$/ do |timestamp|
  @license.update_attribute :updated_at, timestamp
end
