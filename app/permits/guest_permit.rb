class GuestPermit < Permit::Base
  def initialize(ability, options = {})
    super
  end

  def permit?(user, options = {}) 
    super    
    return if !role_match? user   
    can :create, Article
 
    # licenses :user_admin, :blogging
    
    # owns(user, Comment)
  end  
end   

