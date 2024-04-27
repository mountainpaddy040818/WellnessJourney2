class Genre < ApplicationRecord
  # 投稿する際にジャンル名を取得する必要があるため
  belongs_to :health_record, optional: true
  validates :name, presence: true
end
