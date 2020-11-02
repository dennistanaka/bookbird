class Post < ApplicationRecord
	default_scope { order('updated_at DESC') }

	belongs_to :user
	mount_uploader :book_cover, ImageUploader
	has_many :favorites, dependent: :destroy
	has_many :comments

	def favorited_by? user
		favorites.where(user_id: user.id).exists?
	end
end
