require_relative '../../app/commands/base_command'

class BaseCommand
  def self.executed_commands
    @executed_commands ||= []
  end

  def self.inherited subclass
    super

    aspector subclass do
      target do
        def log_execute proxy, &block
          success = proxy.call &block
          if success
            BaseCommand.executed_commands << {
              name: proxy.receiver.class.name,
              params: proxy.receiver.attributes.to_json
            }
          end
        end
      end

      around :execute, :log_execute
    end
  end

  def self.has_executed? name, params = nil
    commands = executed_commands.select { |c|
      c[:name] == name && (!params ||
        params.all? { |k, v| ::JsonPath.new(k).first(c[:params]).to_s == v }
      )
    }
    not commands.empty?
  end
end
