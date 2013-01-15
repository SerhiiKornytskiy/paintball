require 'spec_helper'

describe Photo do
  it {should respond_to(:album)}
  it {should respond_to(:user)}
  
  before(:each) do 
    @attr = { :name => "name", :image => File.open(File.join(Rails.root, '/spec/support/sun.jpg')) } 
  end  

  describe "validation" do
    it "requires name of photo" do
      expect do
      Photo.create(name: "")
      end.to change( Photo, :count ).by(0)
    end  

    it "requires photo" do
      expect do
      Photo.create(name: "awdwad", image: nil)
      end.to change( Photo, :count ).by(0)
    end  
    
    it "creates photo with valid params" do
      expect do
        Photo.create(@attr)
      end.to change( Photo, :count ).by(1)
    end  

  end  

end
