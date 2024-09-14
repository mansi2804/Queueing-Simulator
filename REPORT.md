# MP Report

## Team

- Name(s): Mansi Patil
- AID(s): A20549858

## Self-Evaluation Checklist

Tick the boxes (i.e., fill them with 'X's) that apply to your submission:

- [X] The simulator builds without error
- [X] The simulator runs on at least one configuration file without crashing
- [X] Verbose output (via the `-v` flag) is implemented
- [X] I used the provided starter code
- The simulator runs correctly (to the best of my knowledge) on the provided configuration file(s):
  - [X] conf/sim1.yaml
  - [X] conf/sim2.yaml
  - [X] conf/sim3.yaml
  - [X] conf/sim4.yaml
  - [X] conf/sim5.yaml

## Summary 

For the machine problem 1, I created a queueing simulator in Dart to model various types of queueing processes and evaluate their performance. The implementation involves several key components:

Project Structure:

lib/qsimulator/ Folder:

periodic.dart: This file defines the PeriodicProcess class, which creates a list of events that occur at regular intervals. It specifies how long each event lasts, how often they happen, when the first event starts, and how many events to create. The generateEvents method returns a list of these events based on the given settings. It Contains the implementation for generating periodic events.

singleton.dart: This file defines the SingletonProcess class, which represents a process that generates a single event. It extends the Process class and requires the event’s arrival time and duration as parameters. The generateEvents method uses a private helper function, _createSingleEvent, to create and return a list containing just one event with the specified attributes. This class is used for simulating processes that produce only one event at a fixed time.

stochastic.dart: This file defines the StochasticProcess class, which generates events based on random durations and interarrival times. It extends the Process class and uses exponential distributions to model these times. The generateEvents method creates events starting from a specified time (start) and continues until an end time (end). It generates event durations and interarrival times using exponential distributions, adding each event to the list until the end time is reached. This class is useful for simulating processes with unpredictable event timings.

lib/util/
queue.dart: The queue class implements a priority queue using heap. Elements are added with add, and the highest priority element is removed with removeFirst. It maintains the heap property by adjusting elements up or down as needed with _bubbleUp and _bubbleDown methods. The class also includes methods to check if the queue is empty.

lib/ folder :

simulator.dart: The Simulator class simulates a system where different types of processes (like SingletonProcess, PeriodicProcess, and StochasticProcess) create events based on YAML data. It collects all these events, sorts them by arrival time, and processes them in order. During the simulation, it calculates how long each event waits and prints out details for each event. It also tracks statistics, such as how many events were processed, the total wait time, and the average wait time. Finally, the printReport() function provides a summary of these statistics for each process and for the entire simulation.

Throughout this machine problem 1, I encountered many errors and challenges, but I genuinely enjoyed the process of working through them. While my knowledge in some areas is limited, I found it rewarding to explore new concepts and figure things out along the way. I also enjoyed learning how to handle stochastic events with randomness. Overall, the project pushed me to grow, and I appreciated every opportunity to learn something new.