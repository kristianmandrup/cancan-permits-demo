class SystemPermit < Permit::Base
  def initialize(ability, options = {})
    super
  end

  def permit?(user, options = {}) 
    super
    request = options[:request]
    if request && request.host.localhost? && localhost_manager?
      can(:manage, :all) 
      return :break
    end    
  end  
end      

