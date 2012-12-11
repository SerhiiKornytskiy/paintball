require 'spec_helper'

describe Post do

  it "is invalid without a body" do
    Post.create(:body => "").should_not be_valid
  end

  it "is invalid without a title" do
    Post.create(:title => "").should_not be_valid
  end

  it "valid without video" do 
    Post.create(:video => "", :title => "qqq", :body => "ww").should be_valid
  end	

  it "not valid without user_id" do
    Post.create(:user_id => "").should_not be_valid
  end	
  end
