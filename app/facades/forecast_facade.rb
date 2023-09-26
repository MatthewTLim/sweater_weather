class ForecastFacade
  def receive_future_forecast(end_point, date)
    forecast = ForecastService.get_future_forecast(end_point, date)
    FutureForecast.new(forecast)
  end
  def receive_forecast(latitude, longitude)
    forecast = ForecastService.get_forecast(latitude, longitude)
    Forecast.new(forecast)
  end
end