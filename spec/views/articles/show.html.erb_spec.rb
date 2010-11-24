require 'spec_helper'

describe "articles/show.html.erb" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :user_id => 1,
      :name => "Name",
      :body => "Body"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Body/)
  end
end
