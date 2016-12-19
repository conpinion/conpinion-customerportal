Fabricator :license_pool do
  feature_name { sequence(:name) { |i| "feature.#{i}" } }
  feature_stock 10
  after_build do |pool|
    pool.distributor = Fabricate :distributor unless pool.distributor
    pool.product = Fabricate :product, distributors: [pool.distributor] unless pool.product
  end
end
