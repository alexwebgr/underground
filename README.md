## Underground system
We are looking at implementing a program that will help manage an underground, or subway, system.

The program will be a simple class that can record where and when people enter the subway, leave the subway, and do aggregate calculations on the data to generate statistics.
Base exercise

Implement a new class, UndergroundSystem, that supports three methods:

**check_in(int id, string station_name, int timestamp)**
* A customer with ID card equal to id, gets in the station station_name at time timestamp.
* A customer can only be checked into one place at a time.

**check_out(int id, string station_name, int timestamp)**
* A customer with ID card equal to id, gets out from the station station_name at time timestamp.

**get_average_time(string start_station, string end_station)**
* Returns the average time to travel between the start_station and the end_station.
* The average time is computed from all the previous traveling from start_station to end_station that happened directly.

You can assume all calls to checkIn and checkOut methods are consistent. That is, if a customer gets in at time t1 at some station, then it gets out at time t2 with t2 > t1. All events happen in chronological order.

Here is an example of how this class will be used:
```ruby
s = UndergroundSystem.new
s.check_in(1, "A", 100)
s.check_out(1, "C", 200)
s.get_average_time("A", "C") # => 100
```

### Additional method #1
Add a new method to the UndergroundSystem class:

**get_longest_trip**
* Returns the start_station, end_station, and user ID of the longest trip recorded by the class, based on the time it took for the user to travel from one station to the other.
* If there are two trips tied for the longest travel time, either can be returned.

### Additional method #2
Add a new method to the UndergroundSystem class:

**get_n_longest_trips(int n)**
* Returns the start_station, end_station, and user ID of the n longest trips recorded by the class, based on the time it took for the user to travel from one station to the other.
* If two trips have the same duration, either order can be returned.
