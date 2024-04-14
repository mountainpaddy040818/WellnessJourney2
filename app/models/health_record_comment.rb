# frozen_string_literal: true

class HealthRecordComment < ApplicationRecord
  belongs_to :user
  belongs_to :health_record
  validates :comment, presence: true
end
