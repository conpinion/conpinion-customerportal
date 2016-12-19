When /^I call "([^"]*)"$/ do |name|
  steps %Q{
    When I click "Communication"
    When I click "Call"
    When I select "#{name}" from "Callee"
    When I click the button "Call"
  }
  @callee = User.find_by family_name: name
  @caller = @current_user
end

When /^I receive an incoming call from "([^"]*)"$/ do |name|
  @caller = User.find_by family_name: name
  @callee = @current_user
  wait_for_actioncable_connection
  command = CommunicationCallCommand.new caller: @caller, callee_id: @callee.id
  command.execute
end

When /^The call is answered$/ do
  perform_actioncable_action 'Communication', 'answer', {
    'caller_id': @caller.id,
    'callee_id': @callee.id
  }
end
