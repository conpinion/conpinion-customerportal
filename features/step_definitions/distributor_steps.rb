And /^I am the responsible of that distributor$/ do
  @distributor.responsible = @current_user
  @distributor.save
end
