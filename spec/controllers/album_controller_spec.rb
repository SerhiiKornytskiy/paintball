require 'spec_helper'

describe AlbumsController do

  before(:each) do 
    @admin = FactoryGirl.create(:user)
    @album = FactoryGirl.attributes_for(:album)
  end  

  describe "Post #create" do
    it "denies creation for unsinged user" do
      expect do
        post :create, album: @album
      end.to_not change(Album, :count)
      response.should redirect_to(redirect_to new_user_session_path)
    end  

    it "denies creation with wrong arguments" do
      sign_in(@admin)
      expect do
        post :create, name: ""
      end.to_not change(Album, :count)
       response.should redirect_to(redirect_to albums_path)
    end

    it "creates album with valid params" do
      sign_in(@admin)
      expect do
        post :create, album: @album
      end.to change(Album, :count).by(1)
    end  
  end 

  describe "DELETE #destroy" do
    it "denies deletion for unsinged user" do
      expect do
        delete :destroy, id: @album
      end.to_not change(Album, :count)
      response.should redirect_to(redirect_to new_user_session_path)
    end
    
    it "allows deletion for admin" do
      sign_in(@admin)
      lambda do
        delete :destroy, id: @album
      end.should change(Album, :count).by(-1)
      response.should redirect_to(redirect_to albums_path)
    end  
  end  

end
