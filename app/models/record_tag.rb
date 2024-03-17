class RecordTag < ApplicationRecord
  has_many :health_record_tags, dependent: :destroy
  has_many :health_records, through: :health_record_tags

  validates :tag_name, presence:true, length:{maximum:50}
end
