import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../data/demo_data.dart';
import '../widgets/page_frame.dart';
import '../widgets/trip_card.dart';

class TripsView extends StatelessWidget {
  const TripsView({super.key, required this.onDemoAction});
  final ValueChanged<String> onDemoAction;

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Trip history',
    trailing: Row(
      children: [
        IconButton(
          onPressed: () => onDemoAction('Add filter demo'),
          icon: const Icon(
            Icons.filter_alt_rounded,
            color: AppColors.green,
            size: 29,
          ),
        ),
        IconButton(
          onPressed: () => onDemoAction('Add trip demo'),
          icon: const Icon(Icons.add_circle, color: AppColors.green, size: 29),
        ),
      ],
    ),
    children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
        child: Text(
          'Your recent journeys',
          style: TextStyle(color: AppColors.grey, fontSize: 13),
        ),
      ),
      ...DemoData.trips.map(
        (trip) => TripCard(trip: trip, horizontalMargin: 20),
      ),
    ],
  );
}
