class HealthRecordComment < ApplicationRecord
  belongs_to :user
  belongs_to :health_record
  validates :health_record_comment, presence: true
end
