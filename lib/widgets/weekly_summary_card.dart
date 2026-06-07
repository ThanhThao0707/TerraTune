// lib/widgets/weekly_summary_card.dart
// Card tóm tắt tuần: biểu đồ cột AVG Status + Alert count + AVG Battery

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WeeklySummaryCard extends StatelessWidget {
  const WeeklySummaryCard({super.key});

  // Dữ liệu mock cho biểu đồ (0.0 - 1.0)
  static const _weekData = [0.3, 0.5, 0.4, 0.6, 1.0, 0.7, 0.5];
  static const _days = ['Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.bar_chart_rounded,
                  color: AppColors.textDark, size: 20),
              const SizedBox(width: 8),
              Text(
                'Weekly Summary',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // AVG Status Chart
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.pinkAccent.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AVG Status',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                // Bar chart
                SizedBox(
                  height: 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(_days.length, (i) {
                      final isFriday = i == 4; // Friday - highlight
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Bar
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300 + i * 50),
                              height: 50 * _weekData[i],
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                color: isFriday
                                    ? AppColors.primaryGreen
                                    : AppColors.textLight,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Day label
                            Text(
                              _days[i],
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: isFriday
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                color: isFriday
                                    ? AppColors.textDark
                                    : AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Alert + AVG Battery row
          Row(
            children: [
              Expanded(
                child: _SummaryMiniCard(
                  label: 'Alert',
                  value: '2',
                  valueColor: AppColors.drought,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SummaryMiniCard(
                  label: 'AVG Battery',
                  value: '91%',
                  valueColor: AppColors.healthy,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryMiniCard extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _SummaryMiniCard({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.pinkAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
