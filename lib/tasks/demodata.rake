unless ARGV.any? { |a| a =~ /^gems/ }
  namespace :db do
    desc 'Create some demo data'
    task :demo => :environment do
      User.create! email: 'alice@example.com', password: 'password',
        confirmed_at: DateTime.now, roles: [:admin],
        family_name: 'Alice Agarwal'

      distributor1_user = User.create! email: 'bob@example.com', password: 'password',
        confirmed_at: DateTime.now, roles: [:distributor],
        family_name: 'Bob Bachchan'

      distributor2_user = User.create! email: 'bill@example.com', password: 'password',
        confirmed_at: DateTime.now, roles: [:distributor],
        family_name: 'Bill Bhavani'

      User.create! email: 'carol@example.com', password: 'password',
        confirmed_at: DateTime.now, roles: [:customer],
        family_name: 'Carol Chandran'

      product1 = Product.create! name: 'ToDo List', version: '1.0',
        features: [
          { 'name' => 'user.count', 'type' => 'number', 'default' => 0, 'count' => true },
          { 'name' => 'premium.mode', 'type' => 'boolean', 'default' => false }
        ]
      product2 = Product.create! name: 'Project Manager', version: '2.3',
        features: [{ 'name' => 'max_users', 'type' => 'number', 'default' => -1 }]
      product3 = Product.create! name: 'License Manager', version: '1.0.0',
        features: [{ 'name'=> 'max_users', 'type' => 'number', 'default' => -1 }]

      distributor1 = Distributor.create! company: 'ACME International',
        address: Address.build(street: '2640 Rose Avenue', zip_code: 'PA 19090',
          city: 'Willow Grove', country: 'US'),
        responsible: distributor1_user,
        products: [product1, product2]

      distributor2 = Distributor.create! company: 'Shenzen Master',
        address: Address.build(street: '63 Renmin Lu', zip_code: '266033',
          city: 'Shandong', country: 'CN'),
        responsible: distributor2_user,
        products: [product3]

      customer1 = Customer.create! name: 'Customer 1', company: 'Customer Company 1',
        address: Address.build(street: 'Street 1', zip_code: 'ZIP 1',
          city: 'City 1', country: 'US'),
        distributor: distributor1

      Customer.create! name: 'Customer 2', company: 'Customer Company 2',
        address: Address.build(street: 'Street 2', zip_code: 'ZIP 2',
          city: 'City 2', country: 'US'),
        distributor: distributor1

      Customer.create! name: 'Customer 3', company: 'Customer Company 3',
        address: Address.build(street: 'Street 3', zip_code: 'ZIP 3',
          city: 'City 3', country: 'CN'),
        distributor: distributor2

      Customer.create! name: 'Customer 4', company: 'Customer Company 4',
        address: Address.build(street: 'Street 4', zip_code: 'ZIP 4',
          city: 'City 4', country: 'CN'),
        distributor: distributor2

      [product1, product2].each do |product|
        total = 10
        license = License.create! customer: customer1, product: product,
          features: {
            'user.count' => total,
            'premium.mode' => true
          },
          created_at: 24.months.ago, updated_at: 24.months.ago
        LicenseUsage.create! distributor: distributor1, product: product,
          feature_name: 'user.count', feature_delta: total, feature_total: total,
          created_at: 24.months.ago, updated_at: 24.months.ago

        (1..23).each do |n|
          delta = 10 + rand(90)
          total += delta
          license.update_attributes features: {
            'user.count' => total,
            'premium.mode' => true
          }, created_at: (24-n).months.ago, updated_at: (24-n).months.ago
          LicenseUsage.create! distributor: distributor1, product: product,
            feature_name: 'user.count', feature_delta: delta, feature_total: total,
            created_at: (24-n).months.ago, updated_at: (24-n).months.ago
        end
      end

      LicensePool.create! distributor: distributor1, product: product1,
        feature_name: 'user.count', feature_stock: 100

      LicensePool.create! distributor: distributor1, product: product2,
        feature_name: 'user.count', feature_stock: 100
    end
  end
end
