import 'dart:io';
import 'package:args/args.dart';
import 'package:yaml/yaml.dart';
import 'package:queueing_simulator/simulator.dart';

void main(List<String> args) {
  // configure command line argument parser and parse the arguments
  final parser = ArgParser()
    ..addOption('conf', abbr: 'c', 
                help: 'Config file path')
    ..addFlag('verbose', abbr: 'v', defaultsTo: false, negatable: false,
              help: 'Print verbose output');
  final results = parser.parse(args);

  // print help message if the user omitted the config file path
  if (!results.wasParsed('conf')) {
    print(parser.usage);
    exit(0);
  } 

  // this flag is true if the user provided the verbose flag
  final verbose = results['verbose'];

  // get and check the config file path
  final file = File(results['conf']);
  if (!file.existsSync()) {
    print('Config file not found: ${results['conf']}');
    exit(1);
  }

  // load the config file
  final yamlString = file.readAsStringSync();
  final yamlData = loadYaml(yamlString);

  // create a simulator, run it, and print the report
  final simulator = Simulator(yamlData, verbose: verbose);
  simulator.run();
  simulator.printReport();
}
