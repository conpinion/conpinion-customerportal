class CommunicationCallCommand < BaseCommand
  attribute :caller, User
  attribute :callee_id, Integer

  validates :caller, presence: true
  validate :callee_exists
  validate :callee_is_valid

  attr_reader :callee

  def execute
    return false unless valid?
    ActionCable.server.broadcast "communication_#{callee_id}", {
      action: 'ring',
      callee_id: callee_id,
      caller_id: caller.id,
      caller_name: caller.display_name
    }
    true
  end

  def caller_id
    caller.id
  end

  private
  def callee_exists
    unless callee_id.present?
      if caller.has_role? :distributor
        self.callee_id = User.select_available_admin&.id
      end
    end
    @callee = User.find_by id: callee_id
    unless callee
      errors.add :callee_id, :must_be_present
    end
  end

  def callee_is_valid
    return unless callee
    if callee_id == caller&.id
      errors.add :callee_id, :cant_be_yourself
    elsif not callee.online?
      errors.add :callee_id, :must_be_online
    elsif not caller&.ability&.can? :call, callee
      errors.add :callee_id, :must_be_available
    end
  end
end
