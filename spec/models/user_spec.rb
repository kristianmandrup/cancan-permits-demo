require 'spec_helper'

describe "User permissions to operate on Articles" do  
  before do 
    editor_user = mock_model(User)
    editor_user.stub!(:name).and_return("Editor user")
    editor_user.stub!(:role).and_return("editor")

    admin_user = mock_model(User)
    admin_user.stub!(:name).and_return("Admin user")
    admin_user.stub!(:role).and_return("admin")

    @editor_article = mock_model(Article)
    @editor_article.stub!(:user).and_return(editor_user)
    @editor_article.stub!(:name).and_return('Editor article')

    @admin_article = mock_model(Article)
    @admin_article.stub!(:user).and_return(admin_user)
    @admin_article.stub!(:name).and_return('Admin article')  
    
    @editor = Permits::Ability.new(editor_user)    
    
    # @editor_article = Article.where(:user => editor_user).first
    # @admin_article  = Article.where(:user.neq => editor_user).first 
    
    puts "Editor: #{@editor.inspect}"
    puts "Editor article: #{@editor_article.inspect}"
    puts "Admin article: #{@admin_article.inspect}"
  end

  it "should be able to :read Article he owns" do
    @editor.should be_able_to(:read, Article)
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
    @editor.should_not be_able_to(:delete, @adminarticle)      
  end
end
