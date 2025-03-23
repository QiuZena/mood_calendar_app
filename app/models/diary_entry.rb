class DiaryEntry < ApplicationRecord
  belongs_to :user
  belongs_to :mood
  has_many :keywords
  has_many :likes, dependent: :destroy
  validates :content, presence: true
  validates :entry_date, presence: true
  has_one_attached :image
  has_many :comments, dependent: :destroy
end
