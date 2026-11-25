import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_colors.dart';
import '../viewmodels/main_view_model.dart';
import 'fuel_view.dart';
import 'home_view.dart';
import 'new_trip_view.dart';
import 'profile_view.dart';
import 'reports_view.dart';
import 'trip_summary_view.dart';
import 'trips_view.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainViewModelProvider);
    final viewModel = ref.read(mainViewModelProvider.notifier);
    final message = _showMessage(context);
    return Scaffold(
      body: SafeArea(
        child: switch (state.page) {
          0 => HomeView(
            onDemoAction: message,
            onEndTrip: () => _endTrip(context, ref),
          ),
          1 => TripsView(onDemoAction: message),
          2 => FuelView(onDemoAction: message),
          3 => ReportsView(onDemoAction: message),
          4 => const ProfileView(),
          5 => const NewTripView(),
          6 => const TripSummaryView(),
          _ => HomeView(
            onDemoAction: message,
            onEndTrip: () => _endTrip(context, ref),
          ),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: state.tripActive
            ? () => _endTrip(context, ref)
            : viewModel.openNewTrip,
        backgroundColor: state.tripActive ? AppColors.navy : AppColors.green,
        foregroundColor: Colors.white,
        icon: Icon(state.tripActive ? Icons.stop_rounded : Icons.add_road_rounded),
        label: Text(
          state.tripActive ? 'End Trip' : 'New Trip',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 7,
        child: Row(
          children: [
            Expanded(
              child: _NavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                selected: state.page == 0,
                onTap: () => viewModel.goToPage(0),
              ),
            ),
            Expanded(
              child: _NavItem(
                icon: Icons.route_rounded,
                label: 'Trips',
                selected: state.page == 1,
                onTap: () => viewModel.goToPage(1),
              ),
            ),
            const SizedBox(width: 116),
            Expanded(
              child: _NavItem(
                icon: Icons.local_gas_station_rounded,
                label: 'Fuel',
                selected: state.page == 2,
                onTap: () => viewModel.goToPage(2),
              ),
            ),
            Expanded(
              child: _NavItem(
                icon: Icons.bar_chart_rounded,
                label: 'Reports',
                selected: state.page == 3,
                onTap: () => viewModel.goToPage(3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ValueChanged<String> _showMessage(BuildContext context) =>
      (text) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
      );

  Future<void> _endTrip(BuildContext context, WidgetRef ref) async {
    final endFuel = await showModalBottomSheet<double>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) => const _EndFuelSheet(),
    );
    if (endFuel != null) {
      ref.read(mainViewModelProvider.notifier).endTrip(endFuel);
    }
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: SizedBox(
      height: 58,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 21,
            color: selected ? AppColors.green : AppColors.grey,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: selected ? AppColors.green : AppColors.grey,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

class _EndFuelSheet extends StatefulWidget {
  const _EndFuelSheet();
  @override
  State<_EndFuelSheet> createState() => _EndFuelSheetState();
}

class _EndFuelSheetState extends State<_EndFuelSheet> {
  final _fuelController = TextEditingController();

  @override
  void dispose() {
    _fuelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: EdgeInsets.fromLTRB(
        22,
        18,
        22,
        MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'End this trip',
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter the current fuel remaining to see your trip mileage.',
            style: TextStyle(color: AppColors.grey, fontSize: 13),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _fuelController,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Current fuel remaining (L)',
              prefixIcon: Icon(Icons.local_gas_station_outlined),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 49,
            child: FilledButton(
              onPressed: () {
                final fuel = double.tryParse(_fuelController.text.trim());
                if (fuel == null || fuel < 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter the current fuel in litres.'),
                    ),
                  );
                  return;
                }
                Navigator.pop(context, fuel);
              },
              style: FilledButton.styleFrom(backgroundColor: AppColors.green),
              child: const Text('Finish trip'),
            ),
          ),
        ],
      ),
    ),
  );
}
