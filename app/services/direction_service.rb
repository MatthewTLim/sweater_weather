class DirectionService

  def self.get_directions(start_point, end_point)
    get_url("route?&from=#{start_point}&to=#{end_point}&outFormat=json&ambiguities=ignore")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://www.mapquestapi.com/directions/v2/") do |faraday|
      faraday.params['key'] = Figaro.env.MAPQUEST_API_KEY
      faraday.params['routeType'] = "fastest"
      faraday.params['doReverseGeocode'] = "false"
      faraday.params['enhancedNarrative'] = "false"
      faraday.params['avoidTimedConditions'] = "false"
    end
  end
end