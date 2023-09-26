class RoadTripFacade
  def receive_directions(start_point, end_point)
    direction_details = DirectionService.get_directions(start_point, end_point)
    RoadTrip.new(start_point, end_point, direction_details)
  end
end