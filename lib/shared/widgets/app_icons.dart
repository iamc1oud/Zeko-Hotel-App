import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AppIcons { orderFood, revenue, trend, chat, hourglass }

class AppIcon extends StatelessWidget {
  final AppIcons icon;
  final double size;
  final Color? color;
  final Color? colorFilter;

  const AppIcon(this.icon,
      {super.key, this.size = 24, this.color, this.colorFilter});
  @override
  Widget build(BuildContext context) {
    String i = icon.name.toLowerCase().replaceAll("_", "-");
    String path = 'assets/icons/$i.svg';

    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: SvgPicture.asset(
          path,
          width: size,
          height: size,
          // ignore: deprecated_member_use
          color: color,
          colorFilter: colorFilter == null
              ? null
              : ColorFilter.mode(colorFilter!, BlendMode.overlay),
        ),
      ),
    );
  }
}
