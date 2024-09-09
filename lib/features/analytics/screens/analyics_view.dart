import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zeko_hotel_crm/core/date_parser.dart';
import 'package:zeko_hotel_crm/features/analytics/data/repository/analytics_repository.dart';
import 'package:zeko_hotel_crm/features/analytics/logic/analytics/analytics_cubit.dart';
import 'package:zeko_hotel_crm/features/analytics/screens/widgets/analytics_grid.dart';
import 'package:zeko_hotel_crm/features/analytics/screens/widgets/budget_tracker.dart';
import 'package:zeko_hotel_crm/features/analytics/screens/widgets/filter_button.dart';
import 'package:zeko_hotel_crm/features/auth/logic/cubit/auth_cubit.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/utils/extensions/extension.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

class AnalyticsTabView extends StatefulWidget {
  const AnalyticsTabView({super.key});

  @override
  State<AnalyticsTabView> createState() => _AnalyticsTabViewState();
}

class _AnalyticsTabViewState extends State<AnalyticsTabView> {
  late AnalyticsCubit _analyticsCubit;

  final dateRange = DateRange(
      DateTime.now().subtract(const Duration(seconds: 30)), DateTime.now());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnalyticsCubit(analyticsRepository: getIt.get()),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return FutureBuilder(
              future: context.read<AnalyticsCubit>().getAnalytics(),
              builder: (context, snapshot) {
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Your\nAnalytics',
                              style: textStyles.headlineSmall?.copyWith(
                                  fontFamily: GoogleFonts.ubuntu().fontFamily),
                            ).padding(Paddings.contentPadding).expanded(),
                            BlocSelector<AnalyticsCubit, AnalyticsState,
                                List<DateTime?>>(
                              selector: (state) {
                                return [state.startTime, state.endTime];
                              },
                              builder: (context, state) {
                                return FilledButton.icon(
                                  onPressed: () async {
                                    var selectedRange =
                                        await showDateRangePicker(
                                      context: context,
                                      firstDate: DateTime.now().subtract(
                                          const Duration(days: 10000)),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 10000)),
                                      initialDateRange: DateTimeRange(
                                          start: state[0]!, end: state[1]!),
                                      currentDate: DateTime.now(),
                                    );

                                    if (selectedRange != null) {
                                      context
                                          .read<AnalyticsCubit>()
                                          .getAnalytics(
                                              dateRange: selectedRange);
                                    }
                                  },
                                  icon: const Icon(Icons.calendar_month_sharp),
                                  label: Text(
                                    '${state[0]!.toString().toddMMMyyyy()} - ${state[1]!.toString().toddMMMyyyy()}',
                                    style: textStyles.bodySmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                );
                              },
                            ),
                            Spacing.wlg,
                          ],
                        ),
                        Spacing.hlg,
                        AnalyticsFilterSection()
                            .padding(Paddings.horizontalPadding),
                        Spacing.hlg,
                        const BudgetTrackerSection()
                            .padding(Paddings.horizontalPadding),
                        const AnalyticsCardGridView(),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
