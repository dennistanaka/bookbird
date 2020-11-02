class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@post = Post.find(params[:post_id])
		@comment = current_user.comments.build(body: params[:comment][:body], post_id: @post.id)
		if @comment.save
			redirect_to post_url(@post), notice: "Comment created successfully"
		else
			redirect_to post_url(@post), notice: "Comment could not be created"
		end
	end

	def destroy
		comment = Comment.find_by!(post_id: params[:post_id], user_id: current_user.id)
		comment.destroy
		redirect_to post_url(params[:post_id]), notice: "Comment removed successfully"
	end

end
