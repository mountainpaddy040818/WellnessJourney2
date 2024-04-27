class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :health_record
  # ユーザーIDに紐づけられた投稿IDを取得するため
  validates :user_id, uniqueness: {scope: :health_record_id}
end
