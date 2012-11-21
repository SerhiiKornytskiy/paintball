class PostsController < ApplicationController

	before_filter :authenticate_user!, :only => [:create, :destroy, :new, :edit, :update]
  before_filter :find_post, :only => [:show, :destroy, :edit, :update]

	def show
    @comment = Comment.new
    @comments = Comment.all
	end

	def new
    redirect_to root_path unless user_signed_in? && current_user.admin?
	  @post = Post.new
	end

	def create
	  @post = Post.new(params[:post])
	  @post.user_id = current_user.id
    render :action => "new" unless @post.save
    redirect_to posts_path 
	end

	def destroy
    current_user.posts.find(params[:id]).destroy
    redirect_to root_path
	end

	def edit
    
	end

	def update
    @post.update_attributes(params[:post])
    redirect_to root_path
	end

	def index
    @posts = Post.all.sort.reverse
  	@admin_user = User.find_by_admin(true)
	end	

  protected

  def find_post
    @post = Post.find(params[:id])
  end

end
