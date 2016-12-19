Fabricator :product do
  name { sequence(:name) { |i| "Product#{i > 0 ? i + 1 : ''}" } }
  version '1.2'
end
