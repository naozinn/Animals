class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :animals, dependent: :destroy
  has_many :animal_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :image

  validates :name, presence: true,
  length: { minimum: 2 , maximum: 20},
  uniqueness: true

  validates :introduction,
  length: {  maximum: 50}

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロー取得
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロワー取得

  has_many :followers, through: :reverse_of_relationships, source: :follower # 自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed # 自分をフォローしている人

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search_for(value,how)
    if how == 'perfect'
      User.where(name: value)
    elsif how == 'forward'
      User.where('name LIKE ?', value+'%')
    elsif how == 'backward'
      User.where('name LIKE ?', '%'+value)
    else
      User.where('name LIKE ?', '%'+value+'%')
    end
  end
end
