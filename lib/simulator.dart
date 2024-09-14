import 'package:yaml/yaml.dart';
import './processes.dart';
import './qsimulator/singleton.dart';
import './qsimulator/periodic.dart';
import './qsimulator/stochastic.dart';
import './util/queue.dart';

class ProcessStatistics {
  final int eventCount;
  final int totalWaitTime;

  ProcessStatistics({
    required this.eventCount,
    required this.totalWaitTime,
  });
}

// Class to simulate a queueing system.
class Simulator {
  final bool verbose;
  final List<Process> processes = [];
  late Map<String, dynamic> statistics;

  // Constructor to parse YAML and set up processes.
  Simulator(YamlMap yamlData, {this.verbose = false}) {
    yamlData.forEach((name, fields) {
      switch (fields['type']) {
        case 'singleton':
          processes.add(SingletonProcess(
            name,
            fields['arrival'],
            fields['duration'],
          ));
          break;

        case 'periodic':
          processes.add(PeriodicProcess(
            name,
            fields['duration'],
            fields['interarrival-time'],
            fields['first-arrival'],
            fields['num-repetitions'],
          ));
          break;

        case 'stochastic':
          processes.add(StochasticProcess(
            name,
            double.parse(fields['mean-duration'].toString()),
            double.parse(fields['mean-interarrival-time'].toString()),
            int.parse(fields['first-arrival'].toString()),
            int.parse(fields['end'].toString()),
          ));
          break;
      }
    });
  }

  // Function to handle event simulation based on a priority queue.
  void simulateEventsFromQueue(queue<Event> eventQueue) {
    if (eventQueue.isEmpty) {
      print("No events to simulate.");
      return;
    }

    int totalProcessDuration = 0;
    final Map<String, ProcessStatistics> processStats = {};

    print("\n# Simulation trace\n");

    // Simulating events from the queue
    while (!eventQueue.isEmpty) {
      final event = eventQueue.removeFirst();
      final int waitTime = totalProcessDuration - event.arrivalTime;

      // Update totalProcessDuration if waitTime is less than 0
      if (waitTime < 0) {
        totalProcessDuration = event.arrivalTime;
      }

      print("t=${totalProcessDuration}: ${event.processName}, duration ${event.duration} started "
          "(arrived @ ${event.arrivalTime}, ${waitTime <= 0 ? "no wait" : "waited $waitTime"})");

      totalProcessDuration += event.duration;

      // Updating statistics for each process
      processStats.update(
        event.processName,
        (stats) => ProcessStatistics(
          eventCount: stats.eventCount + 1,
          totalWaitTime: stats.totalWaitTime + (waitTime > 0 ? waitTime : 0),
        ),
        ifAbsent: () => ProcessStatistics(eventCount: 1, totalWaitTime: (waitTime > 0 ? waitTime : 0)),
      );
    }

    // Summarizing the results
    int totalEvents = processStats.values.fold(0, (sum, stats) => sum + stats.eventCount);
    int totalWaitTime = processStats.values.fold(0, (sum, stats) => sum + stats.totalWaitTime);
    double averageWaitTime = totalEvents > 0 ? totalWaitTime / totalEvents : 0;

    statistics = {
      'processStats': processStats,
      'totalEvents': totalEvents,
      'totalWaitTime': totalWaitTime,
      'averageWaitTime': averageWaitTime,
    };
  }

 
  void run() {
    var eventQueue = queue<Event>((a, b) => a.arrivalTime.compareTo(b.arrivalTime));

    // Add generated events to the queue
    for (var process in processes) {
      eventQueue.addAll(process.generateEvents());
    }

    simulateEventsFromQueue(eventQueue);
  }

  // Display the results
  void printReport() {
    final processStats = statistics['processStats'] as Map<String, ProcessStatistics>;
    final int totalEvents = statistics['totalEvents'];
    final int totalWaitTime = statistics['totalWaitTime'];
    final double averageWaitTime = statistics['averageWaitTime'];

    print("# Per-process statistics\n");
    processStats.forEach((processName, stats) {
      final double avgWait = stats.eventCount > 0 ? stats.totalWaitTime / stats.eventCount : 0;
      print("$processName:\n  Events: ${stats.eventCount}\n  Total wait time: ${stats.totalWaitTime}\n  Average wait time: ${avgWait.toStringAsFixed(2)}\n");
    });

    print("---------------------------------------------------------------\n");
    print("# Summary statistics\nTotal events: $totalEvents\nTotal wait time: $totalWaitTime\nAverage wait time: ${averageWaitTime.toStringAsFixed(3)}");
  }
}
