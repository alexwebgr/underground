require 'spec_helper'
require_relative '../app/underground_system'

RSpec.describe UndergroundSystem do
  describe '#get_average_time' do
    context 'when there are two travellers one with check_out' do
      it 'returns 100' do
        s = UndergroundSystem.new
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 200)
        s.check_in(2, 'B', 100)

        expect(s.get_average_time('A', 'C')).to eq 100
      end
    end

    context 'when there are three travellers one with check_out' do
      it 'returns 100' do
        s = UndergroundSystem.new
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 200)
        s.check_in(2, 'B', 100)
        s.check_in(3, 'B', 100)

        expect(s.get_average_time('A', 'C')).to eq 100
      end
    end

    context 'when there are three travellers two with check_out' do
      it 'returns 100' do
        s = UndergroundSystem.new
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 200)
        s.check_in(2, 'A', 100)
        s.check_out(2, 'C', 200)
        s.check_in(3, 'B', 100)

        expect(s.get_average_time('A', 'C')).to eq 100
      end
    end

    context 'when there are three travellers two with check_out one with multiple journeys' do
      it 'returns 100' do
        s = UndergroundSystem.new
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 200)
        s.check_in(1, 'C', 100)
        s.check_out(1, 'A', 200)
        s.check_in(2, 'A', 100)
        s.check_out(2, 'C', 200)
        s.check_in(3, 'B', 100)

        expect(s.get_average_time('A', 'C')).to eq 100
      end
    end

    context 'when there are three travellers two with check_out one with multiple journeys and varying times' do
      it 'returns 183' do
        s = UndergroundSystem.new
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 200)
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 250)
        s.check_in(2, 'A', 100)
        s.check_out(2, 'C', 400)
        s.check_in(3, 'B', 100)

        expect(s.get_average_time('A', 'C')).to eq 183
      end
    end
  end

  describe '#get_longest_trip' do
    context 'when there is a single longest journey' do
      it 'returns the longest one' do
        s = UndergroundSystem.new
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 200)

        expect(s.get_longest_trip).to eq({:start_station=>"A", :end_station=>"C", :id=>1})
      end
    end

    context 'when there are two journeys of the same duration' do
      it 'returns the first one' do
        s = UndergroundSystem.new
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 200)
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 200)

        expect(s.get_longest_trip).to eq({:start_station=>"A", :end_station=>"C", :id=>1})
      end
    end

    context 'when there are 3 journeys of different duration' do
      it 'returns the longest one' do
        s = UndergroundSystem.new
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 300)
        s.check_in(2, 'A', 100)
        s.check_out(2, 'C', 200)
        s.check_in(3, 'A', 100)
        s.check_out(3, 'D', 500)

        expect(s.get_longest_trip).to eq({:start_station=>"A", :end_station=>"D", :id=>3})
      end
    end

    context 'when there are 3 journeys of the different duration and different destination' do
      it 'returns the longest one' do
        s = UndergroundSystem.new
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 300)
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 200)
        s.check_in(2, 'A', 100)
        s.check_out(2, 'D', 450)

        expect(s.get_longest_trip).to eq({:start_station=>"A", :end_station=>"D", :id=>2})
      end
    end
  end

  describe '#get_n_longest_trips' do
    context 'when there are two journeys of the same duration' do
      it 'returns both' do
        s = UndergroundSystem.new
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 200)
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 200)

        expect(s.get_n_longest_trips(2)).to eq([{:start_station=>"A", :end_station=>"C", :id=>1}, {:start_station=>"A", :end_station=>"C", :id=>1}])
      end
    end

    context 'when there are 3 journeys of different duration' do
      it 'returns the two longer ones' do
        s = UndergroundSystem.new
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 300)
        s.check_in(2, 'A', 100)
        s.check_out(2, 'C', 200)
        s.check_in(3, 'A', 100)
        s.check_out(3, 'D', 500)

        expect(s.get_n_longest_trips(2)).to eq([{:start_station=>"A", :end_station=>"D", :id=>3}, {:start_station=>"A", :end_station=>"C", :id=>1}])
      end
    end

    context 'when there are 3 journeys of the different duration and different destination' do
      it 'returns the two longer ones' do
        s = UndergroundSystem.new
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 300)
        s.check_in(1, 'A', 100)
        s.check_out(1, 'C', 200)
        s.check_in(2, 'A', 100)
        s.check_out(2, 'D', 450)

        expect(s.get_n_longest_trips(2)).to eq([{:start_station=>"A", :end_station=>"D", :id=>2}, {:start_station=>"A", :end_station=>"C", :id=>1}])
      end
    end
  end
end
