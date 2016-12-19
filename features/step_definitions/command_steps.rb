Then /^the (.+) command is executed(?: with the following parameters:)?$/ do |*args|
  name = args.shift
  params = args.shift
  if params
    params = params.rows_hash.reduce({}) { |acc, (k, v)| acc[k] = cucumber_steps_replace_variables(v); acc }
  end
  wait_for(BaseCommand).to have_executed("#{name}Command", params), -> do
    "expected command #{name} to be executed but it wasn't"
  end
end
