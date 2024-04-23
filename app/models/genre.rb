class Genre < ApplicationRecord
  belongs_to :health_record, optional: true
  validates :name, presence: true
end
