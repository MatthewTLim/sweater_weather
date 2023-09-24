class LocationFacade
  def receive_lat_lng(location)
    location_details = LocationService.get_long_lat(location)
    Location.new(location_details)
  end
end