# # This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

# if Rails.env.development?
#   # Load Puma config/puma.rb
#   module Rack
#     module Handler
#       module Puma
#         class << self
#           alias :orig_run :run
#
#           def run(_app, _options={})
#             config = ::Puma::Configuration.from_file 'config/puma.rb'
#             events = ::Puma::Events.stdio
#             launcher = ::Puma::Launcher.new(config, :events => events)
#             begin
#               launcher.run
#             rescue Interrupt
#               puts '* Gracefully stopping, waiting for requests to finish'
#               launcher.stop
#               puts '* Goodbye!'
#             end
#           end
#         end
#       end
#     end
#   end
# end

run Rails.application
