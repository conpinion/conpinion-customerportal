Fabricator :user do
  email { sequence(:email) { |i| "user#{i > 0 ? i + 1 : ''}@example.com" } }
  family_name 'Ulli User'
  password 'password'
  confirmed_at { Time.now }
end

Fabricator :online_user, from: :user do
  last_seen 1.minute.ago
end

Fabricator :offline_user, from: :user do
  last_seen 1.month.ago
end

Fabricator :admin_user, from: :user do
  email { sequence(:email) { |i| "admin#{i > 0 ? i + 1 : ''}@example.com" } }
  family_name 'A. Admin'
  password 'password'
  confirmed_at { Time.now }
  roles [:admin]
end

Fabricator :online_admin_user, from: :admin_user do
  last_seen 1.minute.ago
end

Fabricator :offline_admin_user, from: :admin_user do
  last_seen 1.month.ago
end

Fabricator :distributor_user, from: :user do
  email { sequence(:email) { |i| "distributor#{i > 0 ? i + 1 : ''}@example.com" } }
  family_name 'D. Distributor'
  password 'password'
  confirmed_at { Time.now }
  roles [:distributor]
end

Fabricator :customer_user, from: :user do
  email { sequence(:email) { |i| "customer#{i > 0 ? i + 1 : ''}@example.com" } }
  family_name 'C. Customer'
  password 'password'
  confirmed_at { Time.now }
  roles [:customer]
end
