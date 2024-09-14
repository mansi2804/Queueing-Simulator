
import '../processes.dart' ;

class PeriodicProcess extends Process {
  final int duration;
  final int interarrivalTime;
  final int firstArrivalTime;
  int repetitions;

  PeriodicProcess(String name, this.duration, this.interarrivalTime, this.firstArrivalTime, this.repetitions) : super(name);

  @override
  List<Event> generateEvents() {
    List<Event> events = []; // List to store generated events
    int eventTime = firstArrivalTime; // Initialize the time of the first event

 // Generate events based on the number of repetitions
    while (repetitions > 0) {
      events.add(Event(name, eventTime, duration)); // Add event to list
      eventTime += interarrivalTime; // Update event time for next event
      repetitions--; // Decrease the  number of remaining repetitions
    }

    return events; // Return the list of generated events
  }
}
    // Example calculation:
    // Total Number of Events = 50 (Task 1) + 50 (Task 2) = 100
    // Total Wait Time = 600 (Task 1) + 600 (Task 2) = 1200
    // Average Wait Time = Total Wait Time / Total Number of Events = 1200 / 100 = 12.0