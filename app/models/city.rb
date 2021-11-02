require 'uri'
require 'net/http'
require 'json'

class City < ApplicationRecord
  before_save   :downcase_name 
  before_create :add_timezone
  validate :validate_city, on: :create
  validates :name, presence: true, uniqueness: { case_sensitive: false }, 
                   length: { minimum: 2, maximum: 50 }

  has_many :user_cities
  has_many :users, through: :user_cities

  extend FriendlyId
  friendly_id :name, use: :slugged

  #define singletone 
  class << self
    # Retrieves the weather json
    def get_weather(name, type="weather")
      api_key = Rails.application.credentials.open_weather_map[:api_key]
      
      uri = URI("https://api.openweathermap.org/data/2.5/#{type}?q=#{URI.encode(name)}&units=metric&appid=#{api_key}")
      
      res = JSON.parse(Net::HTTP.get(uri))

    end
  end
  
  def validate_city
    res = City.get_weather(name)
    if res['cod'] == "404"
      self.errors.add(:city, "Has no weather information, Kindly select different one")
    end
  end

  def unsubscribe(city, current_user)
    city.users.delete(current_user)
  end

  private

  def downcase_name
    name.downcase!
  end

  # Lookup the correct timezone based on the latitude and longitude.
  def add_timezone
    res = City.get_weather(name)
    unless res["cod"] == "404"
      begin
        self.timezone = Timezone.lookup(res['coord']['lat'], res['coord']['lon']).name
      rescue Timezone::Error::Base => e
        puts "Timezone Error: #{e.message}"
      end
    else
      self.errors.add(:city, "is invalid")
    end
  end

end

