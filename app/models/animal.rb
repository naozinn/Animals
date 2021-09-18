class Animal < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :animal_comments, dependent: :destroy
  validates :title, presence: true

  validates :body, presence: true,
  length: {  maximum: 200}
end
