class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  # "owner"をユーザーモデルに関連づけるため
  belongs_to :owner, class_name: "User"
  # 中間テーブル"group_users"を介してアソシエーション
  has_many :users, through: :group_users, source: :user, dependent: :destroy
  
  # 同じユーザーが２回同じグループに参加するのを防ぐため
  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image

  def get_group_image
    (group_image.attached?) ? group_image : "no_image.jpg"
  end

  def is_owned_by?(user)
    owner.id == user.id
  end
end
