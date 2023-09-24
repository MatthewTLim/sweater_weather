class Api::V0::ForecastController < ApplicationController
  def index
    location_params = params[:location]

    location_facade = LocationFacade.new
    forecast_facade = ForecastFacade.new

    location = location_facade.receive_lat_lng(location_params)

    lat = location.lat
    lng = location.lng
    forecast = forecast_facade.receive_forecast(lat, lng)

    render json: ForecastSerializer.new(forecast)
  end
end