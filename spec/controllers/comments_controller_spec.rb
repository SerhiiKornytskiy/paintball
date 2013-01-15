require 'spec_helper'

describe CommentsController do
  
  before(:each) do
    request.env["HTTP_REFERER"] = "/posts/28"
    @admin = FactoryGirl.create(:user)
    @user = FactoryGirl.create(:regular_user)
    @comment = FactoryGirl.create(:comment)
    @invalid_comment = {content: ""}
  end  

  describe "create" do

    it "denies creating for unsigned user" do 
      lambda do
        post :create, content: @comment
      end.should_not change(Comment, :count)
    end

    it "shuld not create invalid comment" do
      lambda do
        post :create, comment: @invalid_comment
      end.should_not change(Comment, :count)        
    end
  end

    

  describe "for logged in user" do

    before(:each) do
      sign_in(@user)
      @comment = FactoryGirl.attributes_for(:comment)
    end

    it "creates valid comment" do
      lambda do
        post :create, comment: @comment
      end.should change(Comment, :count).by(1)
      response.should redirect_to "/posts/28"
    end
  end 

  describe "delete" do

    it "denies for unauthorised user" do
      lambda do
        delete :destroy, id: @comment
      end.should_not change(Comment, :count)
      response.should redirect_to(new_user_session_path)
    end 

    it "allowes deletion for admin" do
      sign_in(@admin)
      lambda do
        delete :destroy, id: @comment
      end.should change(Comment, :count).by(-1)
      response.should redirect_to "/posts/28"
    end 
    
    it "allowes deletion for it's regular_user" do
      sign_in(@user)
      lambda do
        delete :destroy, id: @comment
      end.should change(Comment, :count).by(-1)
      response.should redirect_to "/posts/28"
    end 

  end  

end
