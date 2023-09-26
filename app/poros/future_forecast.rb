class FutureForecast
  attr_reader :datetime, :temperature, :condition

  def initialize(attributes)
    @datetime = attributes[:forecast][:forecastday][0][:date]
    @temperature = attributes[:forecast][:forecastday][0][:day][:maxtemp_f]
    @condition = attributes[:forecast][:forecastday][0][:day][:condition]
  end
end