require 'spec_helper'

describe Comment do

  it { should belong_to(:user) }
  it { should belong_to(:post) }

  before(:each) do
    @admin = FactoryGirl.create(:user)
    @valid_attr = FactoryGirl.attributes_for(:post)
    @post_message = @admin.posts.create(@valid_attr)
    @comment = FactoryGirl.attributes_for(:comment)
    @invalid_comment = FactoryGirl.attributes_for(:invalid_comment)
  end  

  describe "validation" do
    it "should have content" do
      @post_message.comments.create(@comment).should be_valid
      @post_message.comments.create(@invalid_comment).should_not be_valid
    end  

    it "has associations" do
      @post_message.comments.create(@comment).should respond_to(:post, :user)
    end  

  end  

end  