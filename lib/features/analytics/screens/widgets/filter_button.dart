import 'package:flutter/material.dart';
import 'package:zeko_hotel_crm/utils/extensions/extension.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

class AnalyticsFilterSection extends StatelessWidget {
  const AnalyticsFilterSection({super.key});

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
                        return Column(
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
              itemCount: 6,
              separatorBuilder: (context, index) => Spacing.wxs,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Chip(
                  label: const Text('Sales'),
                  onDeleted: () {},
                );
              }),
        ).expanded()
      ],
    );
  }
}
