class Ability
  include CanCan::Ability
  include Adminpanel::ApplicationHelper

  def initialize(user)

    if user.nil?
    elsif user.role.name == 'Admin'
      can :manage, :all
    else
      user.role.permissions.each do |permission|
        if permission.to_read?
          can :read, symbol_class(permission.resource)
        elsif permission.to_publish?
          can :publish, symbol_class(permission.resource)
        elsif permission.to_create?
          can :create, symbol_class(permission.resource)
        elsif permission.to_update?
          can :update, symbol_class(permission.resource)
        elsif permission.to_destroy?
          can :destroy, symbol_class(permission.resource)
        elsif permission.to_manage?
          can :manage, symbol_class(permission.resource)
        end
      end
    end

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
  end
end
