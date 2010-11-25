class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :oauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :articles
  has_many :comments

  def self.roles
    [:guest, :admin, :editor]
  end    
  
  def has_role? role
    self.role.to_sym == role.to_sym
  end
end
