class AdminPermit < Permit::Base
  def initialize(ability, options = {})
    super
  end

  def permit?(user, options = {}) 
    super
        
    licenses :user_admin, :blogging
  end  
end
