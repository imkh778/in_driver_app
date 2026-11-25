class TripSession {
  const TripSession({
    required this.startLocation,
    required this.endLocation,
    required this.startFuelLitres,
    required this.earning,
  });

  final String startLocation;
  final String endLocation;
  final double startFuelLitres;
  final double earning;
}
