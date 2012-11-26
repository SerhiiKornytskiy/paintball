class CommentsController < ApplicationController
   
    before_filter :authenticate_user!, :only => [:create, :destroy, :new]	

	def new 
      @comment = Comment.new
	end

	def show
      @comments = post.comments.where('post_id = ?', params[:post_id])
	end
	
	def create
      @comment = Comment.new(params[:comment])
	  @comment.user_id = current_user.id
	  redirect_to posts_path if @comment.save 
	end

	def destroy
      @c = Comment.find(params[:id])
      @c.destroy if current_user.admin? or current_user.id == @c.user_id
      redirect_to posts_path
	end

end
