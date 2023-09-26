require "rails_helper"

RSpec.describe "Location Service" do
  describe "#class methods" do
    it "can retrieve information about a specific place" do
      VCR.use_cassette("Location_service_retrieve") do
        start_point = "Portland,OR"
        end_point = "Seattle, WA"

        location = DirectionService.get_directions(start_point, end_point)

        expect(location).to be_a(Hash)
        expect(location).to have_key(:route)
        expect(location[:route]).to have_key(:sessionId)
        expect(location[:route]).to have_key(:realTime)
        expect(location[:route]).to have_key(:distance)
        expect(location[:route]).to have_key(:time)
        expect(location[:route]).to have_key(:formattedTime)
        expect(location[:route]).to have_key(:hasHighway)
        expect(location[:route]).to have_key(:hasTollRoad)
        expect(location[:route]).to have_key(:hasBridge)
        expect(location[:route]).to have_key(:hasSeasonalClosure)
        expect(location[:route]).to have_key(:hasTunnel)
        expect(location[:route]).to have_key(:hasFerry)
        expect(location[:route]).to have_key(:hasUnpaved)
        expect(location[:route]).to have_key(:hasTimedRestriction)
        expect(location[:route]).to have_key(:hasCountryCross)
        expect(location[:route]).to have_key(:legs)
        expect(location[:route][:legs][0]).to have_key(:index)
        expect(location[:route][:legs][0]).to have_key(:hasTollRoad)
        expect(location[:route][:legs][0]).to have_key(:hasHighway)
        expect(location[:route][:legs][0]).to have_key(:hasBridge)
        expect(location[:route][:legs][0]).to have_key(:hasUnpaved)
        expect(location[:route][:legs][0]).to have_key(:hasTunnel)
        expect(location[:route][:legs][0]).to have_key(:hasSeasonalClosure)
        expect(location[:route][:legs][0]).to have_key(:hasFerry)
        expect(location[:route][:legs][0]).to have_key(:hasCountryCross)
        expect(location[:route][:legs][0]).to have_key(:hasTimedRestriction)
        expect(location[:route][:legs][0]).to have_key(:distance)
        expect(location[:route][:legs][0]).to have_key(:time)
        expect(location[:route][:legs][0]).to have_key(:formattedTime)
        expect(location[:route][:legs][0]).to have_key(:origIndex)
        expect(location[:route][:legs][0]).to have_key(:origNarrative)
        expect(location[:route][:legs][0]).to have_key(:destIndex)
        expect(location[:route][:legs][0]).to have_key(:destNarrative)
        expect(location[:route][:legs][0]).to have_key(:maneuvers)
      end
    end
  end
end