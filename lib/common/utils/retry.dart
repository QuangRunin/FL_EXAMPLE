/// Retry asynchronous functions with exponential backoff.
///
/// For a simple solution see [retry], to modify and persist retry options see
/// [RetryOptions]. Note, in many cases the added configurability is
/// unnecessary and using [retry] is perfectly fine.
library;

// ignore_for_file: sort_constructors_first

import 'dart:async';
import 'dart:math' as math;

final math.Random _rand = math.Random();

/// Object holding options for retrying a function.
///
/// With the default configuration functions will be retried up-to 7 times
/// (8 attempts in total), sleeping 1st, 2nd, 3rd, ..., 7th attempt:
///  1. 400 ms +/- 25%
///  2. 800 ms +/- 25%
///  3. 1600 ms +/- 25%
///  4. 3200 ms +/- 25%
///  5. 6400 ms +/- 25%
///  6. 12800 ms +/- 25%
///  7. 25600 ms +/- 25%
class RetryOptions {
  /// Delay factor to double after every attempt.
  ///
  /// Defaults to 200 ms, which results in the following delays:
  ///
  ///  1. 400 ms
  ///  2. 800 ms
  ///  3. 1600 ms
  ///  4. 3200 ms
  ///  5. 6400 ms
  ///  6. 12800 ms
  ///  7. 25600 ms
  ///
  /// Before application of [randomizationFactor].
  final Duration delayFactor;

  /// Percentage the delay should be randomized, given as fraction between
  /// 0 and 1.
  ///
  /// If [randomizationFactor] is `0.25` (default) this indicates 25 % of the
  /// delay should be increased or decreased by 25 %.
  final double randomizationFactor;

  /// Maximum delay between retries, defaults to 30 seconds.
  final Duration maxDelay;

  /// Maximum number of attempts before giving up, defaults to 8.
  final int maxAttempts;

  /// Retry function until call success
  final bool retryUntilSuccess;

  /// Create a set of [RetryOptions].
  ///
  /// Defaults to 8 attempts, sleeping as following after 1st, 2nd, 3rd, ...,
  /// 7th attempt:
  ///  1. 400 ms +/- 25%
  ///  2. 800 ms +/- 25%
  ///  3. 1600 ms +/- 25%
  ///  4. 3200 ms +/- 25%
  ///  5. 6400 ms +/- 25%
  ///  6. 12800 ms +/- 25%
  ///  7. 25600 ms +/- 25%
  const RetryOptions({
    this.delayFactor = const Duration(milliseconds: 200),
    this.randomizationFactor = 0.25,
    this.maxDelay = const Duration(seconds: 30),
    this.maxAttempts = 8,
    this.retryUntilSuccess = false,
  });

  /// Delay after [attempt] number of attempts.
  ///
  /// This is computed as `pow(2, attempt) * delayFactor`, then is multiplied by
  /// between `-randomizationFactor` and `randomizationFactor` at random.
  Duration delay(int attempt) {
    assert(attempt >= 0, 'attempt cannot be negative');

    if (attempt <= 0) {
      return Duration.zero;
    }

    final double rf = randomizationFactor * (_rand.nextDouble() * 2 - 1) + 1;
    final int exp = math.min(attempt, 31); // prevent overflows.
    final Duration delay = delayFactor * math.pow(2.0, exp) * rf;
    return delay < maxDelay ? delay : maxDelay;
  }

  Future<T> retry<T>(FutureOr<T> Function() fn,
      {FutureOr<bool> Function(dynamic)? retryIf,
      FutureOr<void> Function(dynamic)? onRetry}) async {
    int attempt = 0;
    while (true) {
      attempt++;
      try {
        return await fn();
      } catch (e) {
        if ((!retryUntilSuccess && attempt >= maxAttempts) ||
            (retryIf != null && !(await retryIf(e)))) {
          rethrow;
        }
        if (onRetry != null) {
          await onRetry(e);
        }
      }
      await Future<dynamic>.delayed(const Duration(seconds: 5));
    }
  }
}

Future<T> retry<T>(
  FutureOr<T> Function() fn, {
  Duration delayFactor = const Duration(milliseconds: 200),
  double randomizationFactor = 0.25,
  Duration maxDelay = const Duration(seconds: 30),
  int maxAttempts = 8,
  FutureOr<bool> Function(dynamic)? retryIf,
  FutureOr<void> Function(dynamic)? onRetry,
  bool retryUntilSuccess = false,
}) =>
    RetryOptions(
      delayFactor: delayFactor,
      randomizationFactor: randomizationFactor,
      maxDelay: maxDelay,
      maxAttempts: maxAttempts,
      retryUntilSuccess: retryUntilSuccess,
    ).retry(fn, retryIf: retryIf, onRetry: onRetry);
