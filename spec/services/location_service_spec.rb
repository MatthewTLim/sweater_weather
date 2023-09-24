require "rails_helper"

RSpec.describe "Location Service" do
  describe "#class methods" do
    it "can retrieve information about a specific place" do
      city = "Portland"
      state = "OR"

      location = LocationService.get_long_lat(city, state)

      expect(location).to be_a(Hash)
      expect(location).to have_key(:info)
      expect(location).to have_key(:options)
      expect(location).to have_key(:results)

      expect(location[:info]).to have_key(:statuscode)
      expect(location[:info]).to have_key(:copyright)
      expect(location[:info]).to have_key(:messages)

      expect(location[:info][:copyright]).to have_key(:text)
      expect(location[:info][:copyright]).to have_key(:imageUrl)
      expect(location[:info][:copyright]).to have_key(:imageAltText)

      expect(location[:options]).to have_key(:maxResults)
      expect(location[:options]).to have_key(:ignoreLatLngInput)

      expect(location[:results][0]).to have_key(:providedLocation)
      expect(location[:results][0][:providedLocation]).to have_key(:location)

      expect(location[:results][0][:locations][0]).to have_key(:street)
      expect(location[:results][0][:locations][0]).to have_key(:adminArea6)
      expect(location[:results][0][:locations][0]).to have_key(:adminArea6Type)
      expect(location[:results][0][:locations][0]).to have_key(:adminArea5)
      expect(location[:results][0][:locations][0]).to have_key(:adminArea5Type)
      expect(location[:results][0][:locations][0]).to have_key(:adminArea4)
      expect(location[:results][0][:locations][0]).to have_key(:adminArea4Type)
      expect(location[:results][0][:locations][0]).to have_key(:adminArea3)
      expect(location[:results][0][:locations][0]).to have_key(:adminArea3Type)
      expect(location[:results][0][:locations][0]).to have_key(:adminArea1)
      expect(location[:results][0][:locations][0]).to have_key(:adminArea1Type)
      expect(location[:results][0][:locations][0]).to have_key(:postalCode)
      expect(location[:results][0][:locations][0]).to have_key(:geocodeQualityCode)
      expect(location[:results][0][:locations][0]).to have_key(:geocodeQuality)
      expect(location[:results][0][:locations][0]).to have_key(:dragPoint)
      expect(location[:results][0][:locations][0]).to have_key(:sideOfStreet)
      expect(location[:results][0][:locations][0]).to have_key(:linkId)
      expect(location[:results][0][:locations][0]).to have_key(:unknownInput)
      expect(location[:results][0][:locations][0]).to have_key(:type)
      expect(location[:results][0][:locations][0]).to have_key(:latLng)
      expect(location[:results][0][:locations][0]).to have_key(:displayLatLng)
      expect(location[:results][0][:locations][0]).to have_key(:mapUrl)
      expect(location[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(location[:results][0][:locations][0][:latLng]).to have_key(:lng)
      expect(location[:results][0][:locations][0][:displayLatLng]).to have_key(:lat)
      expect(location[:results][0][:locations][0][:displayLatLng]).to have_key(:lng)
    end
  end
end