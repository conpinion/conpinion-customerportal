World(FabricationMethods)

Fabrication::Config.register_with_steps = true

def with_ivars(fabricator)
  @they = yield fabricator
  model = @they.last.class.to_s.underscore
  instance_variable_set("@#{model.pluralize}", @they)
  instance_variable_set("@#{model.singularize}", @they.last)
  Fabrication::Cucumber::Fabrications[model.singularize.gsub(/\W+/, '_').downcase] = @they.last
end

def replace_variables input, &post_processing
  input.gsub(/%{(\w+)}/) do
    key = Regexp.last_match[1]
    value = defined?(JsonSpec) ? JsonSpec.memory[key.to_sym].to_s : nil
    unless value
      value = self.instance_variable_get "@#{key}".to_sym
    end
    value = post_processing.call(value) if post_processing
    value
  end
end

Given /^(\d+) ([^"]*)$/ do |count, model_name|
  with_ivars Fabrication::Cucumber::StepFabricator.new(model_name) do |fab|
    fab.n(count.to_i)
  end
end

Given /^the following ([^"]*):$/ do |model_name, table|
  with_ivars Fabrication::Cucumber::StepFabricator.new(model_name) do |fab|
    fab.from_table(table)
  end
end

Given /^the following ([^"]*) with ID "([^"]+)":$/ do |model_name, id_name, table|
  object = with_ivars(Fabrication::Cucumber::StepFabricator.new(model_name)) do |fab|
    fab.from_table(table)
  end
  self.instance_variable_set "@#{id_name.upcase}".to_sym, object.id
end

Given /^that ([^"]*) has the following ([^" ]*):$/ do |parent, child, table|
  with_ivars Fabrication::Cucumber::StepFabricator.new(child, :parent => parent) do |fab|
    fab.from_table(table)
  end
end

Given /^that ([^"]*) has the following ([^"]*) as ([^"]*):$/ do |parent_name, child_name, assoc_name, table|
  object = with_ivars Fabrication::Cucumber::StepFabricator.new(child_name) do |fab|
    fab.from_table(table)
  end
  parent = instance_variable_get("@#{parent_name}")
  parent.send "#{assoc_name}=", object
  parent.save
end

Given /^that ([^"]*) embeds the following ([^"]*):$/ do |parent_name, child_name, table|
  object = with_ivars Fabrication::Cucumber::StepFabricator.new(child_name) do |fab|
    fab.from_table(table)
  end
  parent = instance_variable_get("@#{parent_name}")
  parent.send "#{child_name}=", object
  parent.save
end

Given /^that ([^"]*) has (\d+) ([^"]*)$/ do |parent, count, child|
  with_ivars Fabrication::Cucumber::StepFabricator.new(child, :parent => parent) do |fab|
    fab.n(count.to_i)
  end
end

Given /^(?:that|those) (.*) belongs? to that (.*)$/ do |children, parent|
  with_ivars Fabrication::Cucumber::StepFabricator.new(parent) do |fab|
    fab.has_many(children)
  end
end

Given /^that (.+) has the file "([^"]+)" attached as (.+)$/ do |model_name, file_name, attribute|
  model = instance_variable_get("@#{model_name}")
  model.send "#{attribute}=", File.new(File.join 'features', 'fixtures', 'files', file_name)
  model.save
end

Then /^I should see (\d+) ([^"]*) in the database$/ do |count, model_name|
  expect(Fabrication::Cucumber::StepFabricator.new(model_name).klass.count).to eq(count.to_i)
end

Then /^I should see the following (.*) in the database:$/ do |model_name, table|
  model_name = model_name.gsub ' ', '_'
  data = table.rows_hash.reduce({}) { |acc, (k, v)| acc[k] = replace_variables(v); acc }.symbolize_keys
  data.update(data) { |_, v| v =~ /true|false/ ? v.to_b : v }
  klass = Fabrication::Cucumber::StepFabricator.new(model_name).klass
  wait_for do
    instances = klass.where(data)
    instances.count
  end.to eq 1
  instance_variable_set("@#{model_name}", klass.where(data)[0])
end
