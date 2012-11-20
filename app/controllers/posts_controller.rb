class PostsController < ApplicationController

	before_filter :authenticate_user!, :only => [:create, :destroy, :new, :edit, :update]

	def show
      @post = Post.find_by_id(params[:id])
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
        if @post.save
          redirect_to posts_path, :notice => "Message updated" 
        else
          render "new", :notice => "Error"
        end
	end

	def destroy
      @post = Post.find(params[:id])
      if @post.user_id == current_user.id
        @post.destroy
      end
      redirect_to root_path
	end

	def edit
      @post = Post.find(params[:id])
	end

	def update
      @post = Post.find(params[:id])
      @post.update_attributes(params[:post])
      redirect_to root_path
	end

	def index
      @posts = Post.all.sort.reverse
  	  @admin_user = User.find_by_admin(true)
	end	

end
