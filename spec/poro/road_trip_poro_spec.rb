require "rails_helper"

RSpec.describe "RoadTrip PORO" do
  before do
    @start_point = "New York, NY"
    @end_point = "Los Angeles, CA"
    @attributes = {
      route: {
        formattedTime: "38:53:43"
      }
    }
  end

  describe "#get_arrival_date" do
    it "calculates and formats the arrival date" do
      road_trip = RoadTrip.new(@start_point, @end_point, @attributes)
      expected_date = (DateTime.now + 1.6211689814814814).strftime("%Y-%m-%d")

      expect(road_trip.get_arrival_date).to eq(expected_date)
    end
  end

  describe "#weather_at_destination" do
    it "retrieves weather information at the destination" do
      road_trip = RoadTrip.new(@start_point, @end_point, @attributes)
      weather = road_trip.weather_at_destination(@end_point)

      expect(weather).to be_a(Hash)
      expect(weather[:datetime]).to be_a(String)
      expect(weather[:temperature]).to be_a(Float)
      expect(weather[:condition]).to be_a(String)
    end
  end
end
