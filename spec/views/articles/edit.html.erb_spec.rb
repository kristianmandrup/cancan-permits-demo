require 'spec_helper'

describe "articles/edit.html.erb" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :new_record? => false,
      :user_id => 1,
      :name => "MyString",
      :body => "MyString"
    ))
  end

  it "renders the edit article form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => article_path(@article), :method => "post" do
      assert_select "input#article_user_id", :name => "article[user_id]"
      assert_select "input#article_name", :name => "article[name]"
      assert_select "input#article_body", :name => "article[body]"
    end
  end
end
