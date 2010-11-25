module Cream
  def self.available_roles
    [:guest, :admin, :editor]
  end
end

require 'cancan-rest-links/rails/configure'
require 'cream'
require 'cream/configure/rails'

# require 'active_support/railtie'
# require 'r3_plugin_toolbox'
# 
# module Cream
#   module Helper
#     module AuthLabel          
#       def auth_labels
#         @auth_labels ||= translate_labels
#       end
# 
#       protected
# 
#       def translate_labels
#         ns_actions = 'cream.actions'
#         labels = {}
#         %w{new edit delete show sign_in sign_out sign_up edit_registration}.each do |action|     
#           labels[action.to_sym] = t "#{ns_actions}.#{action}"
#         end 
#         labels[:confirm] = t 'cream.confirm'
#         labels           
#       end    
#     end
#   end
# end
# 
# Rails3::Plugin::Extender.new do
#   # extend action_controller with methods from some modules
# 
#   extend_rails :controller do
#     extend_from_module Cream::Helper, :auth_label
#   end          
#   
#   extend_rails :view do
#     extend_from_module Cream::Helper, :auth_label
#   end  
# end