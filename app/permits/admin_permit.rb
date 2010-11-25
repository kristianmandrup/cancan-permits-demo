puts "Admin Permit loaded"
puts "Permit::Base is defined" if defined? Permit::Base

class AdminPermit < Permit::Base
  def initialize(ability, options = {})
    super
  end

  def permit?(user, options = {}) 
    super
    true        
    # licenses :user_admin, :blogging
  end  
end

puts "AdminPermit is defined" if defined? AdminPermit