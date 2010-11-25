class EditorPermit < Permit::Base
  def initialize(ability, options = {})
    super
  end

  def permit?(user, options = {}) 
    super
    return if !role_match? user    
    owns(user, Article)

    # a user can manage comments he/she created
    # can :manage, Comment do |comment|
    #   comment.try(:user) == user
    # end            

    # can :create, Comment
  end 
end
