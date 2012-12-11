require 'spec_helper'
require 'user'

describe PostsController do
  
  it "gives access to INDEX" do
    post :index
    response.should be_success
  end


  it "denies access to DESTROY" do
    post :destroy, id: 34
    response.should redirect_to(new_user_session_path)
  end

  it "denies access to UPDATE" do
    post :update, id: 34
    response.should redirect_to(new_user_session_path)
  end

  describe "GET #index" do
    it "shows all posts" do
      post = FactoryGirl.create(:post)
      get :index
      assigns(:posts).should eq([post])
    end
  end

  describe "GET #show" do
    it "shows single post" do
      post = FactoryGirl.create(:post)
      get :show, id: post
      assigns(:post).should eq([post])
    end	
  end

  describe "GET #new" do
    it "renders NEW view" do
      @user = FactoryGirl.create(:user)
      sign_in(@user)
      get :new
      response.should be_success
    end 
  end
  

end
