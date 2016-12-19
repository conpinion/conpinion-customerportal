class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable,
    :trackable, :validatable, :confirmable, :lockable,
    :lastseenable

  attr_accessor :new_email
  attr_accessor :new_password
  attr_accessor :repeat_password
  attr_accessor :skip_confirmation

  include RoleModel

  roles :customer, :distributor, :admin

  validates :new_email, email_format: true, allow_blank: true

  scope :admins, -> { where roles_mask: User.mask_for(:admin) }
  scope :online, -> { where.not(last_seen: nil).where('last_seen > ?', User.offline_timestamp) }

  def display_name
    family_name.present? ? family_name : email
  end

  def online?
    last_seen && last_seen > User.offline_timestamp
  end

  def ability
    @ability ||= Ability.new(self)
  end

  def self.select_available_admin
    online_admins = User.admins.online.order :id
    online_admins.offset(rand(online_admins.count)).first
  end

  def self.offline_timestamp
    Figaro.env.online_timeout.to_i.minutes.ago
  end
end
