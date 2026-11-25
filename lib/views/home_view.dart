import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_colors.dart';
import '../data/demo_data.dart';
import '../models/trip_session.dart';
import '../viewmodels/main_view_model.dart';
import '../widgets/action_tile.dart';
import '../widgets/section_heading.dart';
import '../widgets/stat_tile.dart';
import '../widgets/trip_card.dart';

class HomeView extends ConsumerWidget {
  const HomeView({
    super.key,
    required this.onDemoAction,
    required this.onEndTrip,
  });

  final ValueChanged<String> onDemoAction;
  final VoidCallback onEndTrip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(mainViewModelProvider.notifier);
    final activeTrip = ref.watch(
      mainViewModelProvider.select((state) => state.activeTrip),
    );
    final tripActive = activeTrip != null;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.local_shipping_rounded,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 11),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Driver Demo',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Your workday, in control',
                    style: TextStyle(color: AppColors.grey, fontSize: 11),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => viewModel.goToPage(4),
              icon: const Icon(
                Icons.account_circle_outlined,
                color: AppColors.navy,
                size: 27,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Good morning,',
          style: TextStyle(color: AppColors.grey, fontSize: 14),
        ),
        const Text(
          'Arjun',
          style: TextStyle(
            color: AppColors.navy,
            fontWeight: FontWeight.w800,
            fontSize: 29,
          ),
        ),
        const SizedBox(height: 17),
        _ActiveTripCard(
          activeTrip: activeTrip,
          onStart: viewModel.openNewTrip,
          onEnd: onEndTrip,
        ),
        const SizedBox(height: 22),
        SectionHeading(
          'Today at a glance',
          action: 'Details',
          onTap: () => viewModel.goToPage(3),
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(
              child: StatTile(
                icon: Icons.route,
                value: '02',
                label: 'Trips today',
                color: AppColors.green,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: StatTile(
                icon: Icons.speed,
                value: '27.6',
                label: 'Kilometres',
                color: Color(0xFF4A7DC1),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: StatTile(
                icon: Icons.currency_rupee,
                value: 'â‚¹1,012',
                label: 'Fuel spend',
                color: Color(0xFFD18A31),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const SectionHeading('Quick actions'),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ActionTile(
                icon: tripActive
                    ? Icons.stop_rounded
                    : Icons.play_arrow_rounded,
                label: tripActive ? 'End trip' : 'Start trip',
                onTap: tripActive ? onEndTrip : viewModel.openNewTrip,
                color: AppColors.green,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ActionTile(
                icon: Icons.local_gas_station,
                label: 'Add fuel',
                onTap: () => onDemoAction('Fuel entry demo'),
                color: AppColors.navy,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ActionTile(
                icon: Icons.summarize_outlined,
                label: 'Reports',
                onTap: () => viewModel.goToPage(3),
                color: const Color(0xFF4A7DC1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        SectionHeading(
          'Recent trips',
          action: 'View all',
          onTap: () => viewModel.goToPage(1),
        ),
        const SizedBox(height: 8),
        ...DemoData.trips.take(3).map((trip) => TripCard(trip: trip)),
      ],
    );
  }
}

class _ActiveTripCard extends StatelessWidget {
  const _ActiveTripCard({
    required this.activeTrip,
    required this.onStart,
    required this.onEnd,
  });

  final TripSession? activeTrip;
  final VoidCallback onStart;
  final VoidCallback onEnd;

  @override
  Widget build(BuildContext context) {
    final active = activeTrip != null;
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(21),
        gradient: const LinearGradient(
          colors: [Color(0xFF1B3A52), AppColors.navy],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFF78DCAE)
                      : const Color(0xFFA4B3BE),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                active ? 'TRIP IN PROGRESS' : 'READY WHEN YOU ARE',
                style: const TextStyle(
                  color: Color(0xFFBDCAD3),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Text(
            active
                ? '${activeTrip!.startLocation} â†’ ${activeTrip!.endLocation}'
                : 'A smoother day starts here',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            active
                ? 'Starting fuel Â· ${activeTrip!.startFuelLitres.toStringAsFixed(1)} L'
                : 'Keep your trips and fuel in one place',
            style: const TextStyle(color: Color(0xFFBDCAD3), fontSize: 12),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: FilledButton.icon(
              onPressed: active ? onEnd : onStart,
              style: FilledButton.styleFrom(
                backgroundColor: active ? Colors.white : AppColors.green,
                foregroundColor: active ? AppColors.navy : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              icon: Icon(
                active ? Icons.stop_rounded : Icons.play_arrow_rounded,
              ),
              label: Text(
                active ? 'End trip' : 'Start a trip',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
