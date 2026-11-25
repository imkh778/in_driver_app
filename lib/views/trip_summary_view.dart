import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_colors.dart';
import '../viewmodels/main_view_model.dart';
import '../widgets/route_summary.dart';

class TripSummaryView extends ConsumerWidget {
  const TripSummaryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(
      mainViewModelProvider.select((state) => state.tripSummary),
    );
    final viewModel = ref.read(mainViewModelProvider.notifier);
    if (summary == null) {
      return Center(
        child: FilledButton(
          onPressed: viewModel.closeTripSummary,
          child: const Text('Back to home'),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 28),
      children: [
        const Text(
          'Trip complete',
          style: TextStyle(
            color: AppColors.navy,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Here is your trip summary.',
          style: TextStyle(color: AppColors.grey, fontSize: 13),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(19),
          ),
          child: RouteSummary(
            from: summary.startLocation,
            to: summary.endLocation,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                icon: Icons.route_rounded,
                label: 'DISTANCE',
                value: '${summary.distanceKm.toStringAsFixed(1)} km',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SummaryCard(
                icon: Icons.speed_rounded,
                label: 'MILEAGE',
                value: summary.mileageKmPerLitre == null
                    ? '—'
                    : '${summary.mileageKmPerLitre!.toStringAsFixed(1)} km/L',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                icon: Icons.local_gas_station_outlined,
                label: 'FUEL USED',
                value: '${summary.fuelUsedLitres.toStringAsFixed(1)} L',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SummaryCard(
                icon: Icons.currency_rupee_rounded,
                label: 'EARNING',
                value: '₹${summary.earning.toStringAsFixed(0)}',
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _FuelRow(
                label: 'Fuel at start',
                value: '${summary.startFuelLitres.toStringAsFixed(1)} L',
              ),
              const Divider(height: 20),
              _FuelRow(
                label: 'Fuel remaining',
                value: '${summary.endFuelLitres.toStringAsFixed(1)} L',
              ),
              const Divider(height: 20),
              _FuelRow(label: 'Distance source', value: 'Demo estimate'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 50,
          child: FilledButton(
            onPressed: viewModel.closeTripSummary,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Back to dashboard',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    height: 108,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.green, size: 20),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.navy,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.grey,
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class _FuelRow extends StatelessWidget {
  const _FuelRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: const TextStyle(color: AppColors.grey, fontSize: 12),
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          color: AppColors.navy,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}
