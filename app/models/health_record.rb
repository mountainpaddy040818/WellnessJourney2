class HealthRecord < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :health_record_comments, dependent: :destroy

  has_many :health_record_tags, dependent: :destroy
  has_many :record_tags, through: :health_record_tags

  belongs_to :genre

 # validates :part, presence:true, length: { maximum: 20 }
  validates :exercise, presence:true, length: { maximum: 50 }
  validates :training_content, presence:true, length: { maximum: 50 }
  validates :diet_content, presence:true, length: { maximum: 50 }
  validates :today_impression, presence:true, length: { maximum: 100 }
  validates :tag_name, presence: true, length: { maximum: 20 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @health_record = HealthRecord.where("part LIKE?","#{word}")
    elsif search == "forward_match"
      @health_record = HealthRecord.where("part LIKE?","#{word}%")
    elsif search == "backward_match"
      @health_record = HealthRecord.where("part LIKE?","%#{word}")
    elsif search == "partial_match"
      @health_record = HealthRecord.where("part LIKE?","%#{word}%")
    else
      @health_record = HealthRecord.all
    end
  end

  def save_record_tags(tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.record_tags.pluck(:tag_name) unless self.record_tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.record_tags.delete RecordTag.find_by(tag_name: old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      record_tag = RecordTag.find_or_create_by(tag_name: new_name)
      self.record_tags << record_tag
    end
  end

end
