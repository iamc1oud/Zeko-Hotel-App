import 'package:flutter/material.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/utils/extensions/design_constants.dart';

extension TextFormFieldExtension on Widget {
  Widget centerAlign() {
    return Align(alignment: Alignment.center, child: this);
  }

  Widget leftAlign() {
    return Align(alignment: Alignment.centerLeft, child: this);
  }

  Widget rightAlign() {
    return Align(alignment: Alignment.centerRight, child: this);
  }

  Widget addLabel(String v, [bool? isRequired, TextStyle? requiredTextStyle]) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            v,
            style: textStyles.bodySmall,
          ),
          if (isRequired == true) ...[
            const Text(
              ' *',
            ),
          ]
        ],
      ),
      Spacing.hxs,
      this
    ]);
  }

  Widget disableTouch(bool value) {
    return Opacity(
        opacity: value == true ? 0.4 : 1,
        child:
            IgnorePointer(ignoring: value == true ? true : false, child: this));
  }
}

extension StringExtension on String {
  String removeZero() {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

    String s = toString().replaceAll(regex, '');
    return s;
  }

  String enumToTitleCase() => replaceAll('_', ' ').toTitleCase();
  String get toSentenceCase =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  String get allToCapital => toUpperCase();
  String toTitleCase() => split(" ").map((str) => str.toSentenceCase).join(" ");
}

extension Common on Widget {
  Widget padding(EdgeInsets p) {
    return Padding(padding: p, child: this);
  }

  Widget horizontalGapZero() {
    return Theme(
        data: ThemeData(
            listTileTheme: const ListTileThemeData(
                dense: true,
                visualDensity: VisualDensity.compact,
                horizontalTitleGap: 1,
                contentPadding: EdgeInsets.zero)),
        child: this);
  }

  Widget ignore(bool v) {
    return IgnorePointer(ignoring: v, child: this);
  }

  Widget expanded({int? flex}) {
    return Expanded(flex: flex ?? 1, child: this);
  }

  Widget withRadius([BorderRadius? corner]) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: corner ?? Corners.smBorder),
      child: this,
    );
  }
}
