class FavoritesController < ApplicationController
  def create
  	@post = Post.find(params[:post_id])
  	favorite = current_user.favorites.build(post: @post)
  	# if @favorite.save
  	# 	redirect_to posts_url, notice: "お気に入りに登録しました"
  	# else
  	# 	redirect_to posts_url, alert: "この投稿はお気に入りに登録できません"
  	# end
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
  	favorite = current_user.favorites.find_by!(post_id: @post.id)
  	favorite.destroy
  	# redirect_to posts_url, notice: "お気に入りを解除しました"
  end
end
