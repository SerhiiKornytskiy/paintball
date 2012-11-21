class CommentsController < ApplicationController
   
    before_filter :authenticate_user!, :only => [:create, :destroy, :new]	

	def new 
	  @comment = Comment.new
	end

	def show
      @comments = post.comments.find(params[:post_id])
	end
	
	def create
      @comment = Comment.new(params[:comment])
	  @comment.user_id = current_user.id
	  redirect_to @post if @comment.save 
	end

	def destroy
      redirect_to @post if current_user.comments.find(params[:id]).destroy
	end

end
