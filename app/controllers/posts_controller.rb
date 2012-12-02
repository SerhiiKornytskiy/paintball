class PostsController < ApplicationController

	before_filter :authenticate_user!, :only => [:create, :destroy, :new, :edit, :update] 
  before_filter :find_post, :only => [:show, :destroy, :edit, :update]

	def show
    unless @post
      flash[:notice] = "Post not found"
      redirect_to posts_path
    end
    @comment = Comment.new
    @comments = Comment.all
	end

	def new
    redirect_to root_path unless current_user.admin?
	  @post = Post.new
	end

	def create
	  @post = Post.new(params[:post]) if current_user.admin?
	  @post.user_id = current_user.id
    flash[:notice] = "Enter all fields" unless @post.save
    flash[:notice] = "Post saved" if @post.save
    redirect_to posts_path

	end

	def destroy
    current_user.posts.find(params[:id]).destroy
    flash[:notice] = "Post deleted"
    redirect_to(:back) 
	end

	def edit
    unless @post
      flash[:error] = "Post not found"
      redirect :action => :index
    end
	end

	def update
    @post.update_attributes(params[:post]) if current_user.admin?
    redirect_to posts_path
    flash[:notice] = "Post saved"
	end

	def index
    @posts = Post.find(:all).sort.reverse
    #@admin_user = User.where(admin: true).first
	end	

  protected

  def find_post
    @post = Post.where('id = ?', params[:id]).first
  end

end
