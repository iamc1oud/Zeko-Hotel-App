import 'package:flutter/material.dart';

class Spacing {
  static SizedBox get hlg => SizedBox(height: Insets.lg);
  static SizedBox get hxs => SizedBox(height: Insets.xs);
  static SizedBox get hsm => SizedBox(height: Insets.sm);
  static SizedBox get hmed => SizedBox(height: Insets.med);

  static SizedBox get bottomViewInset =>
      const SizedBox(height: kToolbarHeight - 20);

  static SizedBox get wxs => SizedBox(width: Insets.xs);
  static SizedBox get wsm => SizedBox(width: Insets.sm);
  static SizedBox get wmed => SizedBox(width: Insets.med);
  static SizedBox get wlg => SizedBox(width: Insets.lg);

  static smallHeight() {
    return const SizedBox(height: 12);
  }

  static mediumHeight() {
    return const SizedBox(height: 18);
  }

  static largeHeight() {
    return const SizedBox(height: 24);
  }
}

class Insets {
  static double scale = 1;
  static double offsetScale = 1;
  // Regular paddings
  static double get xs => 4 * scale;
  static double get sm => 8 * scale;
  static double get med => 12 * scale;
  static double get lg => 16 * scale;
  static double get xl => 32 * scale;
  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

class Paddings {
  static final contentPadding = EdgeInsets.all(Insets.med);
  static final horizontalPadding = EdgeInsets.symmetric(horizontal: Insets.med);
  static final verticalPadding = EdgeInsets.symmetric(vertical: Insets.med);

  // Height Paddings
  static EdgeInsets get hxs => EdgeInsets.symmetric(vertical: Insets.xs);
  static EdgeInsets get hsm => EdgeInsets.symmetric(vertical: Insets.sm);
  static EdgeInsets get hmed => EdgeInsets.symmetric(vertical: Insets.med);
  static EdgeInsets get hlg => EdgeInsets.symmetric(vertical: Insets.lg);
  static EdgeInsets get hxl => EdgeInsets.symmetric(vertical: Insets.xl);
}

class Corners {
  static const double sm = 4;
  static const BorderRadius smBorder = BorderRadius.all(smRadius);
  static const Radius smRadius = Radius.circular(sm);

  static const double med = 5;
  static const BorderRadius medBorder = BorderRadius.all(medRadius);
  static const Radius medRadius = Radius.circular(med);

  static const double lg = 12;
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static const Radius lgRadius = Radius.circular(lg);

  static const double circular = 100;
  static const BorderRadius circularBorder = BorderRadius.all(circularRadius);
  static const Radius circularRadius = Radius.circular(100);
}

class Strokes {
  static const double thin = 1;
  static const double thick = 4;
}

class Shadows {
  static List<BoxShadow> get universal => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 10),
      ];
  static List<BoxShadow> get small => [
        BoxShadow(
            color: const Color(0xff333333).withOpacity(.15),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 1)),
      ];
}

class FontSizes {
  /// Provides the ability to nudge the app-wide font scale in either direction
  static double get scale => 1;
  static double get s10 => 10 * scale;
  static double get s11 => 11 * scale;
  static double get s12 => 12 * scale;
  static double get s14 => 14 * scale;
  static double get s16 => 16 * scale;
  static double get s24 => 24 * scale;
  static double get s48 => 48 * scale;
}
