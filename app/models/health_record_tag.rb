# frozen_string_literal: true

class HealthRecordTag < ApplicationRecord
  belongs_to :health_record
  belongs_to :record_tag
end
