class ValueObject
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def self.build attributes = {}
    Address.new.tap do |address|
      attributes.each { |k, v| address.instance_variable_set "@#{k}", v }
    end
  end

  def freeze
    self.valid?
    super
  end

  def valid?(context = nil)
    unless self.frozen?
      current_context, self.validation_context = validation_context, context
      errors.clear
      @valid = run_validations!
    else
      @valid
    end
  ensure
    self.validation_context = current_context unless self.frozen?
  end
end
