require "rails_helper"

RSpec.describe "RoadTripFacade" do
  describe "#class_methods" do
    it "#retrieve_directions" do
      VCR.use_cassette("forecast_endpoint") do
        start_point = "NYC,NY"
        end_point = "LA,CA"

        road_trip_facade = RoadTripFacade.new
        receive_directions = road_trip_facade.receive_directions(start_point, end_point)

        expect(receive_directions).to be_a(RoadTrip)
        expect(receive_directions.start_city).to eq(start_point)
        expect(receive_directions.end_city).to eq(end_point)
        expect(receive_directions.travel_time).to eq("39:00:28")
        expect(receive_directions.weather_at_eta).to eq({
          datetime: "2023-09-28",
          temperature: 83.4,
          condition: "Moderate rain"
        })
      end
    end
  end
end