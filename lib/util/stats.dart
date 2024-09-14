import 'dart:math';

/// This class defines an exponential distribution based on the given rate
/// (λ) or mean (1/λ), and provides a method to generate random numbers from
/// the distribution.
/// 
/// An optional seed can be provided to the constructor to seed the random
/// number generator.
/// 
/// Usage:
/// ```dart
/// var exp = ExpDistribution(mean: 100);
/// var sample = exp.next();
/// ```
class ExpDistribution {
  double _lambda;
  Random _random;

  ExpDistribution({double? rate, double? mean, int seed=0}) : 
    assert(rate != null || mean != null, 'rate or mean is required'),
    _lambda = rate ?? 1 / (mean ?? 1), _random = Random(seed);
  
  double next() {
    return -1 / _lambda * log(1 - _random.nextDouble());
  }

  double get mean => 1 / _lambda;
  set mean(double value) => _lambda = 1 / value;
}
