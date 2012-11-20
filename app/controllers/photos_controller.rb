class PhotosController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  

  def new
    @photo = Photo.new(:album_id => params[:album_id])
  end

  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      redirect_to albums_path
    else
      render :action => 'new'
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      
      redirect_to albums_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to albums_path
  end
end