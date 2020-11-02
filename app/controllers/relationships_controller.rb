class RelationshipsController < ApplicationController
	before_action :authenticate_user!

	def create
		following = current_user.active_relationships.build(followed_id: params[:user_id])

		if User.find(params[:user_id]).locked
			following.accepted = false	
		else
			following.accepted = true
		end

		if following.save
			redirect_to root_path, alert: "フォローしました"
		else
			redirect_to root_path, alert: "フォローできません"
		end
	end

	def destroy
		following = current_user.active_relationships.find_by!(followed_id: params[:user_id])
		following.destroy
		redirect_to root_path, notice: "フォロー解除しました"
	end

	def accept
		@request = current_user.requested_relationships.find_by(id: params[:id])
		if @request.present?
			@request.update(accepted: true)
			redirect_to users_url
		else
			redirect_to users_url, notice: "This account didn't request to follow you"
		end
	end
end
