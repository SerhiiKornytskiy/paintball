require 'spec_helper'

describe Post do

  it { should belong_to(:user) }
  it {should have_many(:comments).dependent(:destroy)}

  before(:each) do
    @admin = FactoryGirl.create(:user)
    @valid_attr = FactoryGirl.attributes_for(:post)
    @invalid_attr = FactoryGirl.attributes_for(:invalid_post)
    @post_message = @admin.posts.create(@valid_attr)
  end

  describe "validation" do  
    it "is invalid without a body" do
      Post.create(body: "", title: "title").should_not be_valid
    end

    it "is invalid without a title" do
      Post.create(body: "body", title: "").should_not be_valid
    end
  
    it "is invalid when blank" do
      Post.create(@invalid_attr).should_not be_valid
    end

    it "is valid without video" do 
      Post.create(@valid_attr, video: "").should be_valid
    end	

    it "not valid without user_id" do
      Post.create(@invalid_attr).should_not be_valid
    end	 
  end 
  
  describe "association" do
    it "should respond to admin" do
      @post_message.user_id.should == @admin.id
    end 
  end

  describe "code" do
    it "should transform youtube link" do
       Post.create(@valid_attr)
       Post.last.code.should == "cPiDloKgsWQ"
    end  
  end  

end
