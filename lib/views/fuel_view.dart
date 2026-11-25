import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../data/demo_data.dart';
import '../widgets/page_frame.dart';
import '../widgets/summary_metric.dart';

class FuelView extends StatelessWidget {
  const FuelView({super.key, required this.onDemoAction});
  final ValueChanged<String> onDemoAction;

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Fuel log',
    trailing: FilledButton.icon(
      onPressed: () => onDemoAction('Fuel entry demo'),
      icon: const Icon(Icons.add, size: 18),
      label: const Text('Add fuel'),
      style: FilledButton.styleFrom(backgroundColor: AppColors.green),
    ),
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
        child: Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(19),
          ),
          child: const Row(
            children: [
              Expanded(
                child: SummaryMetric(
                  label: 'TOTAL FILLED',
                  value: '186 L',
                  size: 13,
                ),
              ),
              Expanded(
                child: SummaryMetric(
                  label: 'FUEL SPEND',
                  value: '₹18,942',
                  size: 13,
                ),
              ),
              Expanded(
                child: SummaryMetric(
                  label: 'AVG. MILEAGE',
                  value: '12.4 km/L',
                  size: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Text(
          'Recent fill-ups',
          style: TextStyle(
            color: AppColors.navy,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      ...DemoData.fuelEntries.map(
        (entry) => Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 9),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                width: 39,
                height: 39,
                decoration: const BoxDecoration(
                  color: AppColors.paleGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_gas_station,
                  color: AppColors.green,
                  size: 19,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.station,
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '${entry.date} · ${entry.quantity}',
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                entry.amount,
                style: const TextStyle(
                  color: AppColors.navy,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
