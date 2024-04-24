class HealthRecord < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :week_favorites, -> { where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day) }

  has_many :health_record_comments, dependent: :destroy

  has_many :health_record_tags, dependent: :destroy
  has_many :record_tags, through: :health_record_tags

  belongs_to :genre

  validates :exercise, presence: true, length: { maximum: 50 }
  validates :training_content, presence: true, length: { maximum: 50 }
  validates :diet_content, presence: true, length: { maximum: 50 }
  validates :today_impression, presence: true, length: { maximum: 100 }
  validates :tag_name, presence: true, length: { maximum: 20 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @health_records = HealthRecord.joins(:genre).where("genres.name LIKE ?", "%#{word}%")
    elsif search == "forward_match"
      @health_records = HealthRecord.joins(:genre).where("genres.name LIKE ?", "#{word}%")
    elsif search == "backward_match"
      @health_records = HealthRecord.joins(:genre).where("genres.name LIKE ?", "%#{word}")
    elsif search == "partial_match"
      @health_records = HealthRecord.joins(:genre).where("genres.name LIKE ?", "%#{word}%")
    else
      @health_records = HealthRecord.all
    end
  end

  def save_record_tags(tags)
    current_tags = self.record_tags.pluck(:tag_name) unless self.record_tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.record_tags.delete RecordTag.find_by(tag_name: old_name)
    end

    new_tags.each do |new_name|
      record_tag = RecordTag.find_or_create_by(tag_name: new_name)
      self.record_tags << record_tag
    end
  end
end
