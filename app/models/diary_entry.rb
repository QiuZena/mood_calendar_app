require "mini_magick"
class DiaryEntry < ApplicationRecord
  belongs_to :user
  belongs_to :mood
  has_many :keywords
  has_many :likes, dependent: :destroy
  validates :content, presence: true
  validates :entry_date, presence: true
  has_one_attached :image
  has_many :comments, dependent: :destroy

  def generate_text_image!
    tempfile = Tempfile.new(["text_image", ".png"], binmode: true)

    MiniMagick::Tool::Convert.new do |img|
      # 设置图像尺寸和渐变背景
      img.size "400x400"
      img << "gradient:#fdf6e3-#fdebd0" # 渐变色从米白到淡橘

      # 设置字体样式
      img.gravity "center"
      img.fill "#5a4332"         # 字体颜色
      img.pointsize "22"
      img.font "Arial-Bold"      # 加粗字体（需系统中存在）
      img.draw "text 0,0 '#{content}'"

      # 输出到 tempfile
      img << tempfile.path
    end

    self.image.attach(
      io: tempfile,
      filename: "text_image.png",
      content_type: "image/png"
    )
  end

  
end
