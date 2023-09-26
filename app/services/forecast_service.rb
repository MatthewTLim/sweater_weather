class ForecastService

  def self.get_future_forecast(end_point, date)
    get_url("forecast.json?q=#{end_point}&dt=#{date}")
  end

  def self.get_forecast(latitude, longitude)
    get_url("forecast.json?q=#{latitude},#{longitude}&days=5")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "http://api.weatherapi.com/v1/") do |faraday|
      faraday.params['key'] = Figaro.env.WEATHER_API_KEY
    end
  end
end