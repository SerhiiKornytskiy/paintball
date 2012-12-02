class CommentsController < ApplicationController
   
    before_filter :authenticate_user!, :only => [:create, :destroy, :new]	

    def new 
    end

    def show
      @comments = post.comments.where('post_id = ?', params[:post_id])
    end

    def create
      @comment = Comment.new(params[:comment])
      @comment.user_id = current_user.id
      flash[:notice] = "Enter comment content" unless  @comment.save
      redirect_to(:back)
    end

    def destroy
      @c = Comment.find(params[:id])
      @c.destroy if current_user.admin? or current_user.id == @c.user_id
      flash[:notice] = "Comment deleted"
      redirect_to(:back) 
    end
end
