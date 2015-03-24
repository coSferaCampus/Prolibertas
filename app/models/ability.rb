class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, User
    can :manage, Person
    can :manage, Alert
  end
end
