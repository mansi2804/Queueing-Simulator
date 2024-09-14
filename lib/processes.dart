// Parent class for all 3 types.
abstract class Process {
  final String name;

  Process(this.name);

  // It will Returns list of all events generated.
  List<Event> generateEvents();
}

// event that occurs once at a fixed time.
class Event {
  final String processName;
  final int arrivalTime;
  final int duration;

  Event(this.processName, this.arrivalTime, this.duration);
}
