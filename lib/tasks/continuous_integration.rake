unless ARGV.any? { |a| a =~ /^gems/ }
  namespace :ci do
    namespace :test do
      desc 'Run RSPec tests'
      task :rspec do
        require 'rspec/core/rake_task'
        RSpec::Core::RakeTask.new(:_specs) do |task|
          task.verbose = false
        end
        Rake::Task[:_specs].invoke
      end

      desc 'Run all tests (rspec and cucumber, fast and slow)'
      task :all => [:rspec] do
        require 'cucumber/rake/task'
        Cucumber::Rake::Task.new(:_features) do |task|
          task.cucumber_opts = '-q -f progress'
        end
        Rake::Task[:_features].invoke
      end

      desc 'Run all tests (rspec and cucumber, but not the slow ones)'
      task :fast => [:rspec] do
        require 'cucumber/rake/task'
        Cucumber::Rake::Task.new(:_features) do |task|
          task.cucumber_opts = '-q -f progress --tags ~@websockets'
        end
        Rake::Task[:_features].invoke
      end
    end
  end
end
