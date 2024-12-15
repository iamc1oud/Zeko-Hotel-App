import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeko_hotel_crm/features/analytics/logic/analytics/analytics_cubit.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

class BudgetTrackerSection extends StatelessWidget {
  const BudgetTrackerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<AnalyticsCubit, AnalyticsState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Budget Tracker',
                style: textStyles.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Spacing.hmed,
              Stack(
                children: [
                  // Full Target Indicator (Background)
                  Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: Corners.circularBorder,
                    ),
                  ),
                  // Achieved Progress Indicator (Foreground)
                  if (state.budget != null)
                    FractionallySizedBox(
                      widthFactor: state.budget!.budgetAchieved /
                          state.budget!.budgetTarget,
                      child: Container(
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: Corners.circularBorder,
                        ),
                      ),
                    ),
                ],
              ),
              Spacing.hlg,
              if (state.budget != null)
                Text(
                  '${((state.budget!.budgetAchieved / state.budget!.budgetTarget) * 100).toStringAsFixed(1)}% Achieved',
                ),
            ],
          );
        },
      ),
    );
  }
}
