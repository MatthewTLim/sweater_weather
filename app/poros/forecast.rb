class Forecast
  attr_reader :id, :type, :current_weather, :daily_weather, :hourly_weather

  def initialize(attributes)
    @id = nil
    @type = "forecast"
    @current_weather = self.class.current_weather(attributes)
    @daily_weather = self.class.daily_weather(attributes)
    @hourly_weather = self.class.hourly_weather(attributes)
  end

  def self.current_weather(attributes)
    {
      last_updated: attributes[:current][:last_updated],
      temp_f: attributes[:current][:temp_f],
      feelslike_f: attributes[:current][:feelslike_f],
      humidity: attributes[:current][:humidity],
      uvi: attributes[:current][:uv],
      visibility: attributes[:current][:vis_miles],
      condition: attributes[:current][:condition][:text],
      icon: attributes[:current][:condition][:icon]
    }
  end

  def self.daily_weather(attributes)
    attributes[:forecast][:forecastday].map do |daily_forecast|
      {
        date: daily_forecast[:date],
        sunrise: daily_forecast[:astro][:sunrise],
        sunset: daily_forecast[:astro][:sunset],
        maxtemp_f: daily_forecast[:day][:maxtemp_f],
        mintemp_f: daily_forecast[:day][:mintemp_f],
        condition: daily_forecast[:day][:condition][:text],
        icon: daily_forecast[:day][:condition][:icon]
      }
    end
  end

  def self.hourly_weather(attributes)
    attributes[:forecast][:forecastday][0][:hour].map do |hourly_forecast|
      {
        time: hourly_forecast[:time],
        temperature: hourly_forecast[:temp_f],
        conditions: hourly_forecast[:condition][:text],
        icon: hourly_forecast[:condition][:icon]
      }
    end
  end
end
