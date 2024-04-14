# frozen_string_literal: true

class RecordTag < ApplicationRecord
  has_many :health_record_tags, dependent: :destroy
  has_many :health_records, through: :health_record_tags
  validates :tag_name, length: {maximum:50}
end
