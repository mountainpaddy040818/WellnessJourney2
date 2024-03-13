class HealthRecord < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :health_record_comments, dependent: :destroy

  validates :part, presence:true, length: { maximum: 20 }
  validates :exercise, presence:true, length: { maximum: 50 }
  validates :training_content, presence:true, length: { maximum: 50 }
  validates :diet_content, presence:true, length: { maximum: 50 }
  validates :today_impression, presence:true, length: { maximum: 100 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # def self.search_for(content, method)
  #   if method == 'perfect'
  #     HealthRecord.where(title: content)
  #   elsif method == 'forward'
  #     HealthRecord.where('name LIKE ?', content + '%')
  #   elsif method == 'backward'
  #     HealthRecord.where('name LIKE ?', '%' + content)
  #   else
  #     HealthRecord.where('name LIKE ?', '%' + content + '%')
  #   end
  # end
end
