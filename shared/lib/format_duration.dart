String formatDuration(Duration d) {
  final hours = d.inHours;
  final minutes = d.inMinutes.remainder(60);
  final seconds = d.inSeconds.remainder(60);

  final parts = <String>[];

  if (hours > 0) parts.add('${hours}h');
  if (minutes > 0) parts.add('${minutes}m');
  if (seconds > 0 || parts.isEmpty) parts.add('${seconds}s');

  return parts.join(' ');
}

String formatDurationSimple(Duration d) {
  final days = d.inDays;

  if (days > 0) {
    return " ${days}d";
  }

  final hours = d.inHours;

  if (hours > 0) {
    return " ${hours}h";
  }

  final minutes = d.inMinutes;

  if (minutes > 0) {
    return " ${minutes}m";
  }

  final inSeconds = d.inSeconds;

  if (inSeconds > 0) {
    return " ${inSeconds}s";
  }

  return "";
}
