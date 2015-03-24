class Ability
  include CanCan::Ability

  def initialize(user)
    can     :manage, User
    can     :manage, Person

    if user.has_role? :volunteer
      cannot  :manage, User
    end
  end
end
