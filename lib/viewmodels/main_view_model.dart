import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/trip_session.dart';
import '../models/trip_summary.dart';

final mainViewModelProvider = NotifierProvider<MainViewModel, MainState>(
  MainViewModel.new,
);

class MainState {
  const MainState({
    this.page = 0,
    this.reportPeriod = 0,
    this.activeTrip,
    this.tripSummary,
  });

  final int page;
  final int reportPeriod;
  final TripSession? activeTrip;
  final TripSummary? tripSummary;
  bool get tripActive => activeTrip != null;

  MainState copyWith({
    int? page,
    int? reportPeriod,
    TripSession? activeTrip,
    TripSummary? tripSummary,
    bool clearActiveTrip = false,
    bool clearTripSummary = false,
  }) => MainState(
    page: page ?? this.page,
    reportPeriod: reportPeriod ?? this.reportPeriod,
    activeTrip: clearActiveTrip ? null : activeTrip ?? this.activeTrip,
    tripSummary: clearTripSummary ? null : tripSummary ?? this.tripSummary,
  );
}

class MainViewModel extends Notifier<MainState> {
  @override
  MainState build() => const MainState();

  void goToPage(int value) => state = state.copyWith(page: value);
  void selectReportPeriod(int value) =>
      state = state.copyWith(reportPeriod: value);
  void openNewTrip() => state = state.copyWith(page: 5);

  void startTrip({
    required String startLocation,
    required String endLocation,
    required double startFuelLitres,
    required double earning,
  }) {
    state = state.copyWith(
      page: 0,
      clearTripSummary: true,
      activeTrip: TripSession(
        startLocation: startLocation,
        endLocation: endLocation,
        startFuelLitres: startFuelLitres,
        earning: earning,
      ),
    );
  }

  void endTrip(double endFuelLitres) {
    final trip = state.activeTrip;
    if (trip == null) return;

    const demoDistanceKm = 18.4;
    final fuelUsed = (trip.startFuelLitres - endFuelLitres)
        .clamp(0.0, double.infinity)
        .toDouble();
    state = state.copyWith(
      page: 6,
      clearActiveTrip: true,
      tripSummary: TripSummary(
        startLocation: trip.startLocation,
        endLocation: trip.endLocation,
        distanceKm: demoDistanceKm,
        startFuelLitres: trip.startFuelLitres,
        endFuelLitres: endFuelLitres,
        fuelUsedLitres: fuelUsed,
        earning: trip.earning,
      ),
    );
  }

  void closeTripSummary() =>
      state = state.copyWith(page: 0, clearTripSummary: true);
}
