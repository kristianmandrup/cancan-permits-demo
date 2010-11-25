class User < ActiveRecord::Base
  has_many :articles
  has_many :comments

  def self.roles
    [:guest, :admin, :editor]
  end    
  
  def has_role? role
    self.role.to_sym == role.to_sym
  end
end
