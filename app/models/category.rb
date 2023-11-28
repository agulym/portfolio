class Category < ApplicationRecord
    has_many :electronics, dependent: :destroy
  
    validates :category_name, presence: true
    validates :effective_life, presence: true
    validates :effective_life, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end