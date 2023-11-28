class NotificationMailer < ApplicationMailer
    def send_when_arrival_warranty_period(electronics)
      @electronics = electronics
      mail to: @electronics.user[:email], subject: '【家電 Announce】メーカー保証期限到来のお知らせ'
    end
  
    def send_when_arrival_useful_life(electronics)
      @electronics = electronics
      mail to: @electronics.user[:email], subject: '【家電 Announce】有効寿命期限到来のお知らせ'
    end
  end