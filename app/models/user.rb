class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    has_many :electronics, dependent: :destroy
  
    attachment :profile_image
  
    validates :user_name, presence: true, length: { in: 2..30 }
  
    def self.search(search, electronics_or_user)
      if electronics_or_user == '2'
        User.where(['user_name LIKE?', "%#{search}%"])
      else
        User.all
      end
    end
  end