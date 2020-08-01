require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :tasks

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(
            name: data["name"],
            email: data["email"],
            encrypted_password: Devise.friendly_token[0,20]
      )
    end
    user
  end

  def get_google_calendar_client
    client = Google::Apis::CalendarV3::CalendarService.new
    secrets = Google::APIClient::ClientSecrets.new({
      "web" => {
        "access_token" => self.access_token,
        "refresh_token" => self.refresh_token,
        "client_id" => ENV["GOOGLE_API_KEY"],
        "client_secret" => ENV["GOOGLE_API_SECRET"]
      }
    })

    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = "refresh_token"

      client.authorization.refresh!
      update_attributes(
        access_token: client.authorization.access_token,
        refresh_token: client.authorization.refresh_token,
        expires_at: client.authorization.expires_at.to_i
      )
    rescue => e
      Rails.logger.error e.message
    end
    client
  end
end
