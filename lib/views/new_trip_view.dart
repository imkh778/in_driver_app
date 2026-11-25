import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_colors.dart';
import '../viewmodels/main_view_model.dart';

class NewTripView extends ConsumerStatefulWidget {
  const NewTripView({super.key});

  @override
  ConsumerState<NewTripView> createState() => _NewTripViewState();
}

class _NewTripViewState extends ConsumerState<NewTripView> {
  final _startLocation = TextEditingController();
  final _endLocation = TextEditingController();
  final _fuel = TextEditingController();
  final _earning = TextEditingController();

  @override
  void dispose() {
    _startLocation.dispose();
    _endLocation.dispose();
    _fuel.dispose();
    _earning.dispose();
    super.dispose();
  }

  void _startTrip() {
    final start = _startLocation.text.trim();
    final end = _endLocation.text.trim();
    final fuel = double.tryParse(_fuel.text.trim());
    final earning = double.tryParse(_earning.text.trim());
    if (start.isEmpty ||
        end.isEmpty ||
        fuel == null ||
        fuel < 0 ||
        earning == null ||
        earning < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter both locations, starting fuel and earning.'),
        ),
      );
      return;
    }
    ref
        .read(mainViewModelProvider.notifier)
        .startTrip(
          startLocation: start,
          endLocation: end,
          startFuelLitres: fuel,
          earning: earning,
        );
  }

  @override
  Widget build(BuildContext context) {
    final hasActiveTrip = ref.watch(
      mainViewModelProvider.select((state) => state.tripActive),
    );
    return ListView(
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 28),
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () =>
                  ref.read(mainViewModelProvider.notifier).goToPage(0),
              icon: const Icon(Icons.arrow_back_rounded, color: AppColors.navy),
            ),
            const SizedBox(width: 3),
            const Text(
              'New trip',
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        const Text(
          'Add a few details to get started.',
          style: TextStyle(color: AppColors.grey, fontSize: 13),
        ),
        const SizedBox(height: 22),
        _TripField(
          controller: _startLocation,
          label: 'Start location',
          hint: 'e.g. Jayanagar',
          icon: Icons.trip_origin_rounded,
        ),
        _TripField(
          controller: _endLocation,
          label: 'End location',
          hint: 'e.g. Majestic',
          icon: Icons.location_on_outlined,
        ),
        _TripField(
          controller: _fuel,
          label: 'Current fuel (litres)',
          hint: 'e.g. 42',
          icon: Icons.local_gas_station_outlined,
          number: true,
        ),
        _TripField(
          controller: _earning,
          label: 'Trip earning (₹)',
          hint: 'e.g. 1,500',
          icon: Icons.currency_rupee_rounded,
          number: true,
        ),
        if (hasActiveTrip)
          Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3DF),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Text(
              'A trip is already active. End it before starting another.',
              style: TextStyle(color: AppColors.navy, fontSize: 12),
            ),
          ),
        Container(
          margin: const EdgeInsets.only(bottom: 18),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.paleGreen,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: AppColors.green,
                size: 19,
              ),
              SizedBox(width: 9),
              Expanded(
                child: Text(
                  'This demo uses an estimated distance of 18.4 km for the trip summary.',
                  style: TextStyle(color: AppColors.navy, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
          child: FilledButton.icon(
            onPressed: hasActiveTrip ? null : _startTrip,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text(
              'Start trip',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ],
    );
  }
}

class _TripField extends StatelessWidget {
  const _TripField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.number = false,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool number;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextField(
      controller: controller,
      keyboardType: number
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.grey, size: 20),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
