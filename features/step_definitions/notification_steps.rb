Then /^I should see a toast containing "([^"]*)"$/ do |text|
  expect(page).to have_selector '#toast-container', text: /#{text}/
end
