class Ability
  include CanCan::Ability

  def initialize(user)

    can :manage, User
    can :manage, Person
    can :manage, Alert

    #if user.has_role? :director
    #  can     :manage, User
    #  can     :manage, Person
    #elsif user.has_role? :worker
    #  can     :manage, User
    #  can     :manage, Person
    #  cannot  :write, User

    if user.has_role? :worker
      cannot  :show, User do |usuario|
        usuario.has_role? :worker or usuario.has_role? :director
      end
    elsif user.has_role? :volunteer
      cannot  :manage, User
    end
  end
end
