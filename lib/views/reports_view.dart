import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_colors.dart';
import '../data/demo_data.dart';
import '../viewmodels/main_view_model.dart';
import '../widgets/page_frame.dart';
import '../widgets/summary_metric.dart';
import '../widgets/trip_card.dart';

class ReportsView extends ConsumerWidget {
  const ReportsView({super.key, required this.onDemoAction});
  final ValueChanged<String> onDemoAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportPeriod = ref.watch(
      mainViewModelProvider.select((state) => state.reportPeriod),
    );
    final viewModel = ref.read(mainViewModelProvider.notifier);
    return PageFrame(
      title: 'Reports',
      trailing: const Icon(
        Icons.calendar_month_outlined,
        color: AppColors.green,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Row(
            children: List.generate(3, (index) {
              const labels = ['Daily', 'Weekly', 'Monthly'];
              final selected = reportPeriod == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => viewModel.selectReportPeriod(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    margin: const EdgeInsets.only(right: 7),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.navy : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      labels[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: selected ? Colors.white : AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.navy,
              borderRadius: BorderRadius.circular(19),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NOVEMBER 25, 2026',
                  style: TextStyle(
                    color: Color(0xFFBDCAD3),
                    letterSpacing: 1,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: SummaryMetric(
                        label: 'TRIPS',
                        value: '02',
                        size: 15,
                      ),
                    ),
                    Expanded(
                      child: SummaryMetric(
                        label: 'DISTANCE',
                        value: '27.6 km',
                        size: 15,
                      ),
                    ),
                    Expanded(
                      child: SummaryMetric(
                        label: 'FUEL',
                        value: '₹1,012',
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 22, 20, 9),
          child: Text(
            'TRIP SUMMARY',
            style: TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.w800,
              letterSpacing: .8,
              fontSize: 10,
            ),
          ),
        ),
        ...DemoData.trips
            .take(2)
            .map(
              (trip) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TripCard(trip: trip),
              ),
            ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 9, 20, 12),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton.icon(
              onPressed: () => onDemoAction('Report preview demo'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: const Text('Preview report'),
            ),
          ),
        ),
      ],
    );
  }
}
