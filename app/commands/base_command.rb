class BaseCommand
  include Virtus.model
  include ActiveModel::Validations

  def to_key
    nil
  end

  def to_model
    self
  end

  def persisted?
    false
  end

  protected
  def merge_errors other_errors
    other_errors.each{|k,v| errors.add k, v}
  end
end
