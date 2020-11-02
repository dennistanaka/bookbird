class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, -> { where(accepted: true) }, class_name: 'Relationship', foreign_key: :following_id
  has_many :passive_relationships, -> { where(accepted: true) }, class_name: 'Relationship', foreign_key: :followed_id
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :following
  has_many :requested_relationships, -> { where(accepted: false) }, class_name: 'Relationship', foreign_key: :followed_id
  has_many :requests, through: :requested_relationships, source: :following
  has_many :comments
  mount_uploader :profile_picture, ProfilePictureUploader
  validates :name, presence: true

  def followed_by?(user)
  	passive_relationships.find_by(following_id: user.id).present?
  end

  def requested_by?(user)
    requested_relationships.find_by(following_id: user.id).present?
  end

end
