class ForecastFacade
  def receive_forecast(latitude, longitude)
    forecast = ForecastService.get_forecast(latitude, longitude)
    Forecast.new(forecast)
  end
end