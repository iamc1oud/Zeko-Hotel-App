import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zeko_hotel_crm/features/analytics/logic/analytics/analytics_cubit.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/shared/widgets/widgets.dart';
import 'package:zeko_hotel_crm/styles.dart';
import 'package:zeko_hotel_crm/utils/extensions/extension.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';
import 'package:zeko_hotel_crm/utils/utils.dart';

class AnalyticsCardGridView extends StatelessWidget {
  const AnalyticsCardGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.7,
          mainAxisSpacing: 20,
          crossAxisSpacing: 5,
          padding: Paddings.contentPadding,
          children: [
            _metricCardView(
                'Total Revenue',
                '$hotelCurrency${state.totalRevenue}',
                Colors.green,
                Colors.green.shade50,
                AppIcons.revenue),
            _metricCardView(
                'Revenue Increase through Zeko',
                '$hotelCurrency${state.revenueFromPlatform}',
                Colors.orange,
                Colors.orange.shade50,
                AppIcons.trend),
            _metricCardView(
                'Total Time Saved',
                '${state.timeSaved?.inHours} Hr ${state.timeSaved?.inMinutes.remainder(60)} Min',
                Colors.indigo,
                Colors.indigo.shade50,
                AppIcons.hourglass),
            _metricCardView(
                'Missed Revenue',
                '$hotelCurrency${state.missedRevenue}',
                Colors.blue,
                Colors.blue.shade50,
                AppIcons.chat)
          ],
        );
      },
    );
  }

  Card _metricCardView(
      String title, String value, Color color, Color cardColor, AppIcons icon) {
    return Card(
      elevation: 0,
      shadowColor: color,
      shape: const RoundedRectangleBorder(borderRadius: Corners.lgBorder),
      color: cardColor,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AutoSizeText(
                    title,
                    maxLines: 2,
                  ).expanded(),
                  Spacing.hmed,
                  Text(
                    value,
                    style: textStyles.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: FontFamily.poppins),
                  ).expanded()
                ],
              ).expanded(),
            ],
          ).padding(Paddings.contentPadding),
          Positioned(
            bottom: -10,
            right: -10,
            child: Card(
              elevation: 20,
              color: color,
              shape: const RoundedRectangleBorder(
                  borderRadius: Corners.circularBorder),
              child: AppIcon(
                icon,
                // color: color,
                color: Colors.white,
                size: 25,
              ).padding(const EdgeInsets.all(8.0)),
            ),
          )
        ],
      ),
    );
  }
}
