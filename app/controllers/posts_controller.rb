class PostsController < ApplicationController

	before_filter :authenticate_user!, :only => [:create, :destroy, :new, :edit, :update] 
    before_filter :find_post, :only => [:show, :destroy, :edit, :update]

	def show
      unless @post
        flash[:error] = "Post not found"
        redirect :action => :index
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
      redirect_to posts_path if @post.save
	end

	def destroy
    current_user.posts.find(params[:id]).destroy
    redirect_to root_path
	end

	def edit
      unless @post
        flash[:error] = "Post not found"
        redirect :action => :index
      end
	end

	def update
      @post.update_attributes(params[:post]) if current_user.admin?
      redirect_to root_path
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
