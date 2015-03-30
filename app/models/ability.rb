class Ability
  include CanCan::Ability

  def initialize(user)

    can :manage, User
    can :manage, Person
    can :manage, Alert
    can :manage, History
    
    if user.has_role? :director
      cannot :show, User do |usuario|
       usuario.has_role? :director and user != usuario
      end

      cannot :destroy, User do |usuario|
       usuario.has_role? :director
      end
    elsif user.has_role? :worker
      cannot [:show, :destroy], User do |usuario|
        usuario.has_role? :worker or usuario.has_role? :director
      end
    elsif user.has_role? :volunteer
      cannot  :manage, User
      cannot  :manage, History
    end
  end
end
