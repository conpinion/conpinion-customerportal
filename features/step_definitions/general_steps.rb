Given /I am authenticated as ([^ ]+)(?: with ID "([^"]+)")?/ do |*args|
  role = args.shift
  id_name = args.shift
  model = {
    'admin' => :admin_user,
    'administrator' => :admin_user,
    'distributor' => :distributor_user,
    'customer' => :customer_user
  }[role]
  @current_user = Fabricate model, email: 'currentuser@example.com'
  @CURRENT_USER_ID = @current_user.id
  login_as(@current_user, :scope => :user)
  if id_name
    self.instance_variable_set "@#{id_name.upcase}".to_sym, @current_user.id
  end
end

Given /^I wait (\d+) seconds?$/ do |n|
  sleep n.to_i
end

Then /^the user "([^"]*)" has the role "([^"]*)"$/ do |email, role|
  user = User.find_by email: email
  expect(user).to have_role role
end

Then /^I should see a file download with the following contents$/ do |content|
  download_content.should =~ /#{content}/
end

Then(/^I should see a file download matching the file "([^"]*)"$/) do |file_name|
  file = File.new File.absolute_path(File.join('features', 'fixtures', 'files', file_name))
  download_content.should == file.read
end
