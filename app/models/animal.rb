class Animal < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :animal_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true

  validates :body, presence: true,
  length: {  maximum: 200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search_for(value,how)
    if how == 'perfect'
      Book.where(title: value)
    elsif how == 'forward'
      Book.where('title LIKE ?', value+'%')
    elsif how == 'backward'
      Book.where('title LIKE ?', '%'+value)
    else
      Book.where('title LIKE ?', '%'+value+'%')
    end
  end
end
