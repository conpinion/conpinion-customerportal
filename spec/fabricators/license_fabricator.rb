Fabricator :license do
  product
  customer
  machine_code { sequence(:machine_code) { |i| "machine#{i > 0 ? i + 1 : ''}" } }
end
