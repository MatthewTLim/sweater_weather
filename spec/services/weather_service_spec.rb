require "rails_helper"

RSpec.describe "Forecast Service" do
  describe "#class_methods" do
    it "can get forecasted weather for 5 days" do
      lat = "45.51179"
      long = "-122.67563"

      forecast = ForecastService.get_forecast(lat, long)

      expect(forecast).to be_a(Hash)
      expect(forecast).to have_key(:location)
      expect(forecast).to have_key(:current)
      expect(forecast).to have_key(:forecast)

      expect(forecast[:location]).to have_key(:name)
      expect(forecast[:location]).to have_key(:region)
      expect(forecast[:location]).to have_key(:country)
      expect(forecast[:location]).to have_key(:lat)
      expect(forecast[:location]).to have_key(:lon)
      expect(forecast[:location]).to have_key(:tz_id)
      expect(forecast[:location]).to have_key(:localtime_epoch)
      expect(forecast[:location]).to have_key(:localtime)

      expect(forecast[:current]).to have_key(:last_updated)
      expect(forecast[:current]).to have_key(:temp_f)
      expect(forecast[:current]).to have_key(:condition)
      expect(forecast[:current]).to have_key(:humidity)
      expect(forecast[:current]).to have_key(:cloud)
      expect(forecast[:current]).to have_key(:feelslike_f)
      expect(forecast[:current]).to have_key(:vis_miles)
      expect(forecast[:current]).to have_key(:uv)
      expect(forecast[:current][:condition]).to have_key(:text)
      expect(forecast[:current][:condition]).to have_key(:icon)

      expect(forecast[:forecast]).to have_key(:forecastday)

      expect(forecast[:forecast][:forecastday][0]).to have_key(:date)
      expect(forecast[:forecast][:forecastday][0]).to have_key(:day)
      expect(forecast[:forecast][:forecastday][0]).to have_key(:astro)
      expect(forecast[:forecast][:forecastday][0]).to have_key(:hour)

      expect(forecast[:forecast][:forecastday][0][:day]).to have_key(:maxtemp_f)
      expect(forecast[:forecast][:forecastday][0][:day]).to have_key(:mintemp_f)
      expect(forecast[:forecast][:forecastday][0][:day]).to have_key(:totalsnow_cm)
      expect(forecast[:forecast][:forecastday][0][:day]).to have_key(:condition)
      expect(forecast[:forecast][:forecastday][0][:day][:condition]).to have_key(:text)
      expect(forecast[:forecast][:forecastday][0][:day][:condition]).to have_key(:icon)


      expect(forecast[:forecast][:forecastday][0][:astro]).to have_key(:sunrise)
      expect(forecast[:forecast][:forecastday][0][:astro]).to have_key(:sunset)

      expect(forecast[:forecast][:forecastday][0][:hour][0]).to have_key(:time)
      expect(forecast[:forecast][:forecastday][0][:hour][0]).to have_key(:temp_f)
      expect(forecast[:forecast][:forecastday][0][:hour][0]).to have_key(:condition)
      expect(forecast[:forecast][:forecastday][0][:hour][0][:condition]).to have_key(:text)
      expect(forecast[:forecast][:forecastday][0][:hour][0][:condition]).to have_key(:icon)
    end
  end
end