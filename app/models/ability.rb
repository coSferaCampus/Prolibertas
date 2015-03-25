class Ability
  include CanCan::Ability

  def initialize(user)
    can     :manage, User
    can     :manage, Person

    
    if user.has_role? :director
      cannot  [:show, :destroy], User do |usuario|
        usuario.has_role? :director
      end
    elsif user.has_role? :worker
      cannot  [:show, :destroy], User do |usuario|
        usuario.has_role? :worker or usuario.has_role? :director
      end
    elsif user.has_role? :volunteer
      cannot  :manage, User
    end
  end
end
