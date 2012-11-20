class CommentsController < ApplicationController
    before_filter :authenticate_user!, :only => [:create, :destroy, :new]	

	def new
		redirect_to root_path unless user_signed_in? 
	    @comment = Comment.new
	   
	end

	def show
      @comments = Comment.find_by_post_id(params[:post_id])
	end
	
	def create
      @comment = Comment.new(params[:comment])
	  @comment.user_id = current_user.id
      render action: "new" 
	end

	def destroy
      @c = Comment.find(params[:id])
      @c.destroy
      
	end
end
