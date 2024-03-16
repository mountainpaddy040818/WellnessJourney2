class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
         #:recoverable,
         #, :rememberable

  has_many :health_records, dependent: :destroy
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :health_record_comments, dependent: :destroy
  
  # フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # フォローしているユーザーを取得
  has_many :followings, through: :active_relationships , source: :followed
  # フォロワーを取得
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, length: { maximum: 50 }
  validates :introduction, length: { maximum: 50 }
  validates :target, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  # フォロー実行
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  
  # フォロー解除
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end
  
  # フォローしているか？
  def following?(user)
    followings.include?(user)
  end

  # def self.search_for(content, method)
  #   if method == 'perfect'
  #     User.where(name: content)
  #   elsif method == 'forward'
  #     User.where('name LIKE ?', content + '%')
  #   elsif method == 'backward'
  #     User.where('name LIKE ?', '%' + content)
  #   else
  #     User.where('name LIKE ?', '%' + content + '%')
  #   end
  # end

  GUEST_USER_EMAIL = "guest@example.com"
    def self.guest
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        user.password = SecureRandom.urlsafe_base64
        user.name = "Guest User"
      end
    end

    def guest_user?
      email == GUEST_USER_EMAIL
    end
end
