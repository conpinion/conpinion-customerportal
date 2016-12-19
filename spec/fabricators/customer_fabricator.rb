Fabricator :customer do
  name { sequence(:name) { |i| "Customer#{i > 0 ? i + 1 : ''}" } }
  company { sequence(:company) { |i| "Customer#{i > 0 ? i + 1 : ''} Company" } }
  company 'Customer Company'
  address
  distributor
end
