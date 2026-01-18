import 'dart:async';

class DriftFreeTimer {
  final Duration interval;
  final void Function(Timer timer) callback;
  Timer? _timer;
  late DateTime _nextExpected;

  DriftFreeTimer(this.interval, this.callback) {
    _nextExpected = DateTime.now().add(interval);
    _scheduleNext();
  }

  void _scheduleNext() {
    final now = DateTime.now();
    var delay = _nextExpected.difference(now);

    if (delay.isNegative) delay = Duration.zero;

    _timer = Timer(delay, _tick);
  }

  void _tick() {
    _nextExpected = _nextExpected.add(interval);

    callback(_timer!);
    _scheduleNext();
  }

  void cancel() => _timer?.cancel();
}
