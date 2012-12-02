class AlbumsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :find_album, :only => [:show, :edit, :update, :destroy]

  def index
    @albums = Album.all
  end

  def show
    rescue ActiveRecord::RecordNotFound  
  end

  def new
    @album = Album.new
  end

  def create
    flash[:error] = "Choose name for album" unless Album.new(params[:album]).save
    redirect_to albums_path
  end

  def edit

  end

  def update
    render :action => 'edit' unless @album.update_attributes(params[:album])
    redirect_to root_path
    flash[:notice] = "Successfully updated Album."
  end

  def destroy
    flash[:notice] = "Successfully destroyed Album." if @album.destroy
    redirect_to albums_path
  end
  
  protected

  def find_album
    @album = Album.where('id = ?', params[:id]).first
  end

end