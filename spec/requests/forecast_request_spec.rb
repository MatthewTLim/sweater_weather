require "rails_helper"

RSpec.describe Api::V0::ForecastController, type: :controller do
  describe "#class_methods" do
    before do
      @location_details = "Portland,OR"
    end

    it "returns a successful response" do
      get :index, params: { location: @location_details }

      expect(response).to have_http_status(:success)
    end

    it "returns forecast data for the specified location" do
      get :index, params: { location: @location_details }

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to be_a(Hash)
      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to have_key(:id)
      expect(response_body[:data]).to have_key(:type)
      expect(response_body[:data]).to have_key(:attributes)
      expect(response_body[:data][:attributes]).to have_key(:current_weather)
      expect(response_body[:data][:attributes][:current_weather]).to have_key(:last_updated)
      expect(response_body[:data][:attributes][:current_weather]).to have_key(:temp_f)
      expect(response_body[:data][:attributes][:current_weather]).to have_key(:feelslike_f)
      expect(response_body[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(response_body[:data][:attributes][:current_weather]).to have_key(:uvi)
      expect(response_body[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(response_body[:data][:attributes][:current_weather]).to have_key(:condition)
      expect(response_body[:data][:attributes][:current_weather]).to have_key(:icon)
      expect(response_body[:data][:attributes][:daily_weather][0]).to have_key(:sunrise)
      expect(response_body[:data][:attributes][:daily_weather][0]).to have_key(:maxtemp_f)
      expect(response_body[:data][:attributes][:daily_weather][0]).to have_key(:mintemp_f)
      expect(response_body[:data][:attributes][:daily_weather][0]).to have_key(:condition)
      expect(response_body[:data][:attributes][:daily_weather][0]).to have_key(:icon)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to have_key(:time)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to have_key(:temperature)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to have_key(:conditions)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to have_key(:icon)
    end

    it "returns only the required information" do
      get :index, params: { location: @location_details }

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:last_updated_epoch)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:temp_c)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:is_day)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:code)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:wind_mph)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:wind_kph)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:wind_dergee)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:wind_dir)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:pressure_mb)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:pressure_in)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:pressure_mm)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:precip_in)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:feelslike_c)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:vis_km)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:gust_mph)
      expect(response_body[:data][:attributes][:current_weather]).to_not have_key(:gust_kph)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:date_epoch)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:maxtemp_c)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:mintemp_c)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:avgtemp_c)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:avgtemp_f)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:maxwind_mph)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:maxwind_kph)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:totalprecip_mm)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:totalprecip_in)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:avgvis_km)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:avgvis_miles)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:avghumidity)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:code)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:daily_will_it_rain)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:daily_will_it_snow)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:daily_chance_of_rain)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:daily_chance_of_snow)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:uv)
      expect(response_body[:data][:attributes][:hourly_weather][0]).to_not have_key(:totalsnow_cm)
    end
  end
end