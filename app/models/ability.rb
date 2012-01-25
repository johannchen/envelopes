class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.id.nil?
      cannot :manage, :all
    else
      can :read, :reports
      can :create, :transfer
      can :manage, [Envelope, Transaction, Account, Distribution], :user_id => user.id
    end
  end
end
