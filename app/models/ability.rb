require 'cancancan'

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :read, :update, :destroy, :to => :modify

    if user.has_role? :admin
      can :manage, :all
      cannot :destroy, User, id: user.id
    elsif user.has_role? :distributor
      can :read, :dashboard
      can [:read, :update, :edit_password, :edit_email], User, id: user.id
      can :read, Distributor, responsible_id: user.id
      can :read, Product do |product|
        product.distributors.include? Distributor.find_by(responsible: user)
      end
      can :modify, Customer, distributor: { responsible_id: user.id }
      cannot :destroy, Customer
      can :create, Customer
      can :call, User, roles_mask: User.mask_for(:admin)
      can :modify, License, customer: { distributor: { responsible_id: user.id } }
      can :download, License, customer: { distributor: { responsible_id: user.id } }
      cannot :destroy, License
      can :create, License
      can :read, LicensePool, distributor: { responsible_id: user.id }
      can :read, Download
      can :download, Download
    elsif user.has_role? :customer
      can [:read, :update, :edit_password, :edit_email], User, id: user.id
      can :read, License, customer: { responsible_id: user.id }
      can :read, Download
      can :download, Download
    end
  end
end
