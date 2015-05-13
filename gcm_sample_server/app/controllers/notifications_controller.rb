class NotificationsController < ApplicationController
  def create
    if !Rpush::Gcm::App.find_by_name("android-gcm-sample")
      app = Rpush::Gcm::App.new
      app.name = "android-gcm-sample"
      app.auth_key = Rails.application.secrets.gcm_server_key
      app.connections = 1
      app.save!
    end
    
    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name("android-gcm-sample")
    n.registration_ids = [Rails.application.secrets.gcm_client_registration_key]
    message = Time.new.to_s
    n.data = { message: message }
    n.save!
  end
end
