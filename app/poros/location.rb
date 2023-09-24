class Location
  attr_reader :lat, :lng

  def initialize(attributes)
    @lat = attributes[:results][0][:locations][0][:latLng][:lat]
    @lng = attributes[:results][0][:locations][0][:latLng][:lng]
  end
end