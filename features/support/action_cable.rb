def wait_for_actioncable_connection
  wait_for { ActionCable.server.connections.count }.to eq 1
end

def perform_actioncable_action channel, action, params
  wait_for_actioncable_connection
  action = {
    'action': action,
  }.merge params
  data = {
    'identifier' => "{\"channel\":\"#{channel}Channel\"}",
    'data' => action.to_json
  }
  ActionCable.server.connections.first.subscriptions.perform_action data
end
