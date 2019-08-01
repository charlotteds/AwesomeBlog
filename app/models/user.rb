class User < ApplicationRecord
  has_many :microposts
  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }

  # REGEX = Regular expression
  # To validate correct email structure
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true

  def active_relationships
    Relationship.where(follower_id: id)
  end

  def passive_relationships
    Relationship.where(followed_id: id)
  end

  def follow(other_user)
    Relationship.create(
      follower_id: id,
      followed_id: other_user.id
    )
  end

  def relationship(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def following
    ids = active_relationships.pluck(:followed_id)
    User.where(id: ids)
  end

  def followers
    ids = passive_relationships.pluck(:follower_id)
    User.where(id: ids)
  end

  def feed
    ids = following.pluck(:id)
    ids << id

    Micropost.where(user_id: ids)
    # SELECT * FROM microposts WHERE user_id = [2, 3] OR user_id = 1
  end
end
