class Notice < ApplicationRecord
    belongs_to :admin
  
    validates :title, :text, presence: true
  end