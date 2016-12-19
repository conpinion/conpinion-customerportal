Fabricator :license_usage do
  feature_name { sequence(:name) { |i| "feature.#{i}" } }
  feature_delta 5
  feature_total 20
  after_build do |usage|
    usage.distributor = Fabricate :distributor unless usage.distributor
    usage.product = Fabricate :product, distributors: [usage.distributor] unless usage.product
  end
end
