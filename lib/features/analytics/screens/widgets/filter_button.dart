import 'package:flutter/material.dart';
import 'package:zeko_hotel_crm/utils/extensions/extension.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

class AnalyticsFilterSection extends StatelessWidget {
  AnalyticsFilterSection({super.key});

  final categories = ['Upsell', 'Housekeeping', 'Laundary', 'Sunday Special'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Filter icon button
        Badge.count(
          count: 5,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.grey.shade200),
            child: IconButton(
                icon: const Icon(Icons.graphic_eq_outlined),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return const Column(
                          children: [Text('Show department names')],
                        );
                      });
                }),
          ),
        ),
        Spacing.wxs,
        // List all departments
        SizedBox(
          height: kMinInteractiveDimension,
          child: ListView.separated(
              itemCount: categories.length,
              separatorBuilder: (context, index) => Spacing.wxs,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Chip(
                  backgroundColor: Colors.grey.shade200,
                  label: Text(categories.elementAt(index)),
                  onDeleted: () {},
                  deleteIconColor: Colors.grey,
                );
              }),
        ).expanded()
      ],
    );
  }
}
