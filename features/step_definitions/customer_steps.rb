And /^I am the responsible distributor of that customer$/ do
  @distributor ||= Fabricate :distributor, responsible: @current_user
  @customer.distributor = @distributor
  @customer.save
end
