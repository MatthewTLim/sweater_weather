class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta, :id

  def initialize(start_point, end_point, attributes)
    @id = nil
    @start_city = start_point
    @end_city = end_point
    @travel_time = attributes[:route][:formattedTime]
    @weather_at_eta = self.weather_at_destination(end_point)
  end

  def get_arrival_date
    if @travel_time != nil
    travel_hours, travel_minutes, travel_seconds = @travel_time.split(':').map(&:to_i)

    current_datetime = DateTime.now

    hours_fraction = Rational(travel_hours, 24) #24 hours in a day
    minutes_fraction = Rational(travel_minutes, 1440) #1440 minutes in a day
    seconds_fraction = Rational(travel_seconds, 86400) #86400 seconds in a day

    arrival_datetime = current_datetime + hours_fraction + minutes_fraction + seconds_fraction

    formatted_arrival_date = arrival_datetime.strftime("%Y-%m-%d")

    formatted_arrival_date
    else
      @travel_time
    end
  end

  def weather_at_destination(end_point)
    forecast_facade = ForecastFacade.new

    date = self.get_arrival_date

    weather = forecast_facade.receive_future_forecast(end_point, date)

    weather_at_eta = {
      datetime: weather.datetime,
      temperature: weather.temperature,
      condition: weather.condition[:text]
    }
  end
end