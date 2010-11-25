require 'spec_helper'
require 'cancan/matchers'

module Permits::Roles
  def self.available
    User.roles
  end
end

describe "User permissions to operate on Articles" do
  before do
    @editor_user         = User.create(:name => "Editor",  :role => "editor")
    @admin_user          = User.create(:name => "Admin",   :role => "admin")

    @editor_article   = Article.create(:user => @editor_user, :name => "Editor article")
    @admin_article    = Article.create(:user => @admin_user, :name => "Admin article")          

    @editor = Permits::Ability.new(@editor_user)    
    
    # specify custom options to consider in permit
    # @editor = Permits::Ability.new(@editor_user, :request => request)    
  end

  context "Editor" do
    it "should be able to :read any Article" do
      @editor.should be_able_to(:read, Article)
    end

    it "should be able to :read Article he owns" do
      @editor.should be_able_to(:read, @editor_article)      
    end

    it "should be able to :update Article he owns" do
      @editor.should be_able_to(:update, @editor_article)      
    end
    
    it "should NOT be able to :update Article he does NOT own" do
      @editor.should_not be_able_to(:update, @admin_article)      
    end
    
    it "should be able to :delete Article he owns" do
      @editor.should be_able_to(:delete, @editor_article)      
    end
    
    it "should NOT be able to :update Article he does NOT own" do
      @editor.should_not be_able_to(:delete, @admin_article)      
    end
  end
  
end
