class UndergroundSystem
  private

  def initialize
    @journeys = []
  end

  def find(id)
    @journeys.find { |journey| journey[:id] == id }
  end

  def longest_trips
    @journeys
      .each_with_object([]) { |journey, memo| memo << { id: journey[:id], time: journey[:check_out_time] - journey[:check_in_time] } unless journey[:check_out_time].nil? }
      .sort { |a, b| b[:time] <=> a[:time] }
      .map { |journey| find(journey[:id]).slice(:id, :start_station, :end_station) }
  end

  public

  def check_in(id, station_name, timestamp)
    @journeys << { id: id, start_station: station_name, end_station: nil, check_in_time: timestamp, check_out_time: nil }
  end

  def check_out(id, station_name, timestamp)
    journey = @journeys.find { |journey| journey[:id] == id && journey[:check_out_time].nil? }
    journey[:check_out_time] = timestamp
    journey[:end_station] = station_name
  end

  def get_average_time(start_station, end_station)
    times = @journeys
      .select { |t| t[:start_station] == start_station && t[:end_station] == end_station }
      .each_with_object([]) { |journey, memo| memo << journey[:check_out_time] - journey[:check_in_time] }

    times.sum / times.count
  end

  def get_longest_trip
    longest_trips.first
  end

  def get_n_longest_trips(n)
    longest_trips.first(n)
  end
end