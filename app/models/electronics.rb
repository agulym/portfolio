class Electronics < ApplicationRecord
    belongs_to :user
    belongs_to :category
  
    attachment :image
  
    validates :maker, :product, :model, :purchase_amount, :purchase_day, :warranty_period, :start_operation, :useful_life, presence: true
  
    def after_month
      @category = Category.find(category_id)
      d1 = start_operation
      d2 = @category.effective_life
      d = d1&.since(d2.month)
      self.useful_life = d
    end
  
    def self.compare_warranty_period
      @electronics = Electronics.all
      require 'date'
      @electronics.each do |electronics|
        d1 = Date.today
        d2 = electronics.warranty_period
        d3 = d2.prev_month(1)
        NotificationMailer.send_when_arrival_warranty_period(electronics).deliver if d1 == d3
      end
    end
  
    def self.compare_useful_life
      @electronics = Electronics.all
      require 'date'
      @electronics.each do |electronics|
        d1 = Date.today
        d2 = electronics.useful_life
        d3 = d2.prev_month(1)
        NotificationMailer.send_when_arrival_useful_life(electronics).deliver if d1 == d3
      end
    end
  
    def self.search(search, electronics_or_user)
      if electronics_or_user == '1'
        Electronics.where(['maker LIKE? OR product LIKE? OR model LIKE?', "%#{search}%", "%#{search}%", "%#{search}%"])
      else
        Electronics.all
      end
    end
  end