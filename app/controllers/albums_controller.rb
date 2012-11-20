class AlbumsController < ApplicationController

before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(params[:album])
    if @album.save 
      flash[:notice] = "Successfully created Album."
      redirect_to album_path
    else
      render :action => 'new'
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
      if @album.update_attributes(params[:album])
        flash[:notice] = "Successfully updated Album."
        redirect_to root_path
      else
        render :action => 'edit'
      end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:notice] = "Successfully destroyed Album."
    redirect_to albums_url
  end
end