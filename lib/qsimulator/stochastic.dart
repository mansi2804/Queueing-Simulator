//importing required files
import '../processes.dart'; 
import '../util/stats.dart';

class StochasticProcess extends Process {
  final double meanDuration;
  final double meanInterarrival;
  final int start;
  final int end;
  late final ExpDistribution durationDist;
  late final ExpDistribution interarrivalDist;

  StochasticProcess(
    String name,
    this.meanDuration,
    this.meanInterarrival,
    this.start,
    this.end,
  ) : super(name) {
    durationDist = ExpDistribution(mean: meanDuration);
    interarrivalDist = ExpDistribution(mean: meanInterarrival);
  }

  @override
  List<Event> generateEvents() {
    List<Event> events = [];
    int currentTime = start;

    while (currentTime < end) {
      int duration = _generateDuration();  // Generate random duration
      if (currentTime + duration > end) break;  // break if event duration exceeds end time

      events.add(Event(name, currentTime, duration));  // Add event to list
      currentTime = currentTime + _generateInterarrival(); // Update current time with the next interarrival
      if (currentTime >= end) break;
    }

    return events; // Return the list of generated events
  }

  int _generateDuration() => durationDist.next().round();    // Generate random duration 
  int _generateInterarrival() => interarrivalDist.next().round();  // Generate a random interarrival time 
}
