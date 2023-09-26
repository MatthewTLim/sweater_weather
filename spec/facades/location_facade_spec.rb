require "rails_helper"

RSpec.describe "Location Facade" do
  describe "#class_methods" do
    it "gets latitude and longitude using location" do
      VCR.use_cassette("location_facade_lat_lng") do
        location = "Portland,OR"

        location_facade = LocationFacade.new
        receive_location = location_facade.receive_lat_lng(location)

        expect(receive_location).to be_a(Location)

        expect(receive_location.lat).to eq(45.51179)
        expect(receive_location.lng).to eq(-122.67563)
      end
    end
  end
end