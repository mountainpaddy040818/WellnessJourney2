class RecordTag < ApplicationRecord
  has_many :health_record_tags, dependent: :destroy
  
  # 中間テーブル"health_record_tags"を介してアソシエーション
  has_many :health_records, through: :health_record_tags
  validates :tag_name, length: {maximum:50}
end
