import 'package:flutter/material.dart';
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
          ),
          if (isRequired == true) ...[
            Text(
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

extension Common on Widget {
  Widget padding(EdgeInsets p) {
    return Padding(padding: p, child: this);
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
