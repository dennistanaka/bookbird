class UsersController < ApplicationController
  def index
  	users = User.all
    @rows = get_user_rows(users, 3)

  end

  def show
  	@user = User.find(params[:id])
  	@posts = @user.posts.page(params[:page]).per(10)
    @post = Post.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(email: params[:user][:email], locked: params[:user][:locked])
      redirect_to user_path(@user), notice: 'ユーザー情報を更新しました!'
    else
      render :edit, notice: 'ユーザー情報を更新できませんでした...'
    end
  end

  def requests
    @user = User.find(params[:id])
    @requests = @user.requests
  end

  def favorites
  	@user = User.find(params[:id])
    @post = Post.new
  	@favorite_posts = Array.new
  	@user.favorites.includes(:post).order("posts.updated_at DESC").each do |favorite|
  		@favorite_posts.push(favorite.post)
  	end
  end

  def following
    @user = User.find(params[:id])
    @rows = get_user_rows(@user.following, 2)
    @post = Post.new
  end

  def followers
    @user = User.find(params[:id])
    @rows = get_user_rows(@user.followers, 2)
    @post = Post.new
  end

  private
    def get_user_rows(users, size)
      rows = Array.new

      user_count = 0

      while user_count < users.count do
        row_user_count = 0
        row = Array.new

        while row_user_count < size do
          user = users[user_count]
          row.push(user)
          row_user_count = row_user_count + 1

          user_count = user_count + 1
          if user_count == users.count
            break
          end
        end

        rows.push(row)

      end

      return rows
    end
end
