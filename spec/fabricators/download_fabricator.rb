Fabricator :download do
  name { sequence(:name) { |i| "Download#{i > 0 ? i + 1 : ''}" } }
  product
end
