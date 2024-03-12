class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :health_record
  
  validates :user_id, uniqueness: {scope: :health_record_id}
  
end
