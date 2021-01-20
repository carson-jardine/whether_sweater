class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(trip_data, travel_time, weather_at_eta)
    @id = nil
    @start_city = trip_data[:origin]
    @end_city = trip_data[:destination]
    @travel_time = format_time(travel_time)
    @weather_at_eta = weather_at_eta
  end

  def format_time(travel_time)
    time = (travel_time[:formatted_time]).split(':')
    "#{time[0]} hour(s), #{time[1]} minute(s)"
  end
end
