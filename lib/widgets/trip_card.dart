import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/trip_info.dart';
import 'route_summary.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip, this.horizontalMargin = 0});
  final TripInfo trip;
  final double horizontalMargin;

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.fromLTRB(horizontalMargin, 0, horizontalMargin, 9),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                trip.date,
                style: const TextStyle(color: AppColors.grey, fontSize: 11),
              ),
            ),
            Text(
              trip.distance,
              style: const TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 5),
            const Icon(Icons.chevron_right, color: AppColors.grey, size: 18),
          ],
        ),
        const SizedBox(height: 10),
        RouteSummary(from: trip.from, to: trip.to),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            trip.time,
            style: const TextStyle(color: AppColors.grey, fontSize: 10),
          ),
        ),
      ],
    ),
  );
}
