class SystemPermit < Permit::Base
  def initialize(ability, options = {})
    super
  end

  def permit?(user, options = {}) 
    super
    true        
    # licenses :user_admin, :blogging
  end  
end
