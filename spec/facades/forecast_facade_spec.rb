require "rails_helper"

RSpec.describe "ForecastFacade" do
  describe "#class_methods" do
    it "gets forecast using latitude and longitude" do
      VCR.use_cassette("forecast_facade_lat_lng") do
        lat = "45.51179"
        lng = "-122.67563"

        forecast_facade = ForecastFacade.new
        receive_forecast = forecast_facade.receive_forecast(lat, lng)

        expect(receive_forecast).to be_a(Forecast)
        expect(receive_forecast.current_weather).to be_a(Hash)
        expect(receive_forecast.daily_weather).to be_an(Array)
        expect(receive_forecast.hourly_weather).to be_an(Array)
      end
    end
  end
end