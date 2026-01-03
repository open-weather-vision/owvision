class StationNotFoundException implements Exception {
  late final String msg;

  StationNotFoundException(int id) {
    msg = "Station with id '$id' not found!";
  }

  @override
  String toString() {
    return "StationNotFoundException: $msg";
  }
}
