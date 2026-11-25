class TripSummary {
  const TripSummary({
    required this.startLocation,
    required this.endLocation,
    required this.distanceKm,
    required this.startFuelLitres,
    required this.endFuelLitres,
    required this.fuelUsedLitres,
    required this.earning,
  });

  final String startLocation;
  final String endLocation;
  final double distanceKm;
  final double startFuelLitres;
  final double endFuelLitres;
  final double fuelUsedLitres;
  final double earning;

  double? get mileageKmPerLitre =>
      fuelUsedLitres > 0 ? distanceKm / fuelUsedLitres : null;
}
