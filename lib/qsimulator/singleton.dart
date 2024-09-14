import '../processes.dart';

class SingletonProcess extends Process {
  final int arrival;
  final int duration;

  SingletonProcess(String name, this.arrival, this.duration) : super(name);  // Constructor to initialize SingletonProcess.

  @override
  List<Event> generateEvents() {
     // Generate a list containing single event
    return _createSingleEvent(name, arrival, duration);
  }
  //Helper function to create single event.
  List<Event> _createSingleEvent(String processName, int arrivalTime, int duration) {
    return [Event(processName, arrivalTime, duration)];   // Create and return a list with one Event object
  }
}

// Example calculation:

// Event 1 (Process 1): Starts at 0, Wait = 0
// Event 2 (Process 2): Starts at 4, Wait = 1
// Event 3 (Process 3): Starts at 11, Wait = 6
// Event 4 (Process 4): Starts at 14, Wait = 4

// Total Number of Events: 4
// Total Wait Time = 0 + 1 + 6 + 4 = 11
// Average Wait Time = 11 / 4 = 2.75