class PhotosController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :find_photo, :only => [:edit, :update, :destroy]

  def new
    @photo = Photo.new(:album_id => params[:album_id])
  end

  def create
    @photo = Photo.new(params[:photo])
    redirect_to albums_path if @photo.save
  end

  def edit
    
  end

  def update
    redirect_to albums_path if @photo.update_attributes(params[:photo])  
  end

  def destroy
    redirect_to albums_path if @photo.destroy
  end

  protected

  def find_photo
    @photo = Photo.where(' id = ?', params[:id]).first
  end  

end