class StationNotFoundException implements Exception {
  late final String msg;

  StationNotFoundException(String uuid) {
    msg = "Station with uuid '$uuid' not found!";
  }

  @override
  String toString() {
    return "StationNotFoundException: $msg";
  }
}
