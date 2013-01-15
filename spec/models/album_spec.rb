require 'spec_helper'

describe Album do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
  end  

  it {should belong_to(:user)}
  it {should have_many(:photos).dependent(:destroy)}
  
  describe "validation" do
    
    it "should have name filled" do
      @user.albums.create(name: "  ").should_not be_valid
      @user.albums.create(name: "").should_not be_valid
      @user.albums.create(name: "123123").should be_valid
    end
    
    it "should have associated user" do
      @user.albums.create(name: "123123").should respond_to(:user)
    end 

  end  

end
