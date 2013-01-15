require 'spec_helper'
require 'user'

describe PostsController do

  before(:each) do
    @post = FactoryGirl.attributes_for(:post)
    @invalid_post = FactoryGirl.attributes_for(:invalid_post)
  end

  it "gives access to INDEX" do
    get :index
    response.should be_success
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
      assigns(:post).should eq(post)
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

  describe "POST #create" do
    before(:each) do 
      @user = FactoryGirl.create(:user)
      sign_in(@user)
    end

    it "creates valid post" do
      lambda  do
        post :create, post: @post
      end.should change(Post, :count).by(1)
      response.should redirect_to(posts_path)
      flash[:notice].should_not be_nil
    end 

    it "holds invalid post" do
      lambda  do
        post :create, post:  @invalid_post
      end.should_not change(Post, :count)
      response.should redirect_to(posts_path)
      flash[:notice].should_not be_nil
    end
  end
  
  describe "DELETE #destroy" do
 
    it "deletes post for admin" do
      @user = FactoryGirl.create(:user)
      sign_in(@user)
      @post = FactoryGirl.create(:post)
      lambda do
        delete :destroy, id:  @post
      end.should change(Post, :count).by(-1)
      response.should redirect_to(posts_path)
    end 

    it "denies access for regular user" do
      @user = FactoryGirl.create(:regular_user)
      sign_in(@user)
      @post = FactoryGirl.create(:another_post)
      delete :destroy, id:  @post
      response.should redirect_to(posts_path)
    end  

    it "denies access for unsigned user" do
      @post = FactoryGirl.create(:another_post)
      delete :destroy, id:  @post
      response.should redirect_to(new_user_session_path)
    end  
  end

  describe "GET edit" do
    describe "failure" do 
      it "redirects unsigned user" do
        get :edit, id: 34
        response.should redirect_to(new_user_session_path) 
      end

      it "redirects unsigned user" do
        get :edit, id: 34
        response.should redirect_to(new_user_session_path) 
      end
    end  
  end 


  describe "PUT #update" do
    describe "failure" do

      it "denies unsigned user" do
        put :edit, id: 3
        response.should redirect_to(new_user_session_path)
      end
      
      it "denies regular user" do
        @regular_user = FactoryGirl.create(:regular_user)
        sign_in(@regular_user)
        @post = FactoryGirl.attributes_for(:post)
        put :edit, id: @post, post: @post
        response.should redirect_to(root_path)
      end

    end  

    describe "success" do 
      it "updates post for admin" do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
        @post = FactoryGirl.create(:post)
        @post.update_attributes(title: "888")
        @post.title.should == "888"
      end

    end  
  end  

end
