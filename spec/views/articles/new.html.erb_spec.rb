require 'spec_helper'

describe "articles/new.html.erb" do
  before(:each) do
    assign(:article, stub_model(Article,
      :user_id => 1,
      :name => "MyString",
      :body => "MyString"
    ).as_new_record)
  end

  it "renders new article form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => articles_path, :method => "post" do
      assert_select "input#article_user_id", :name => "article[user_id]"
      assert_select "input#article_name", :name => "article[name]"
      assert_select "input#article_body", :name => "article[body]"
    end
  end
end
