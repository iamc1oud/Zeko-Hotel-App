import 'package:flutter/material.dart';
import 'package:zeko_hotel_crm/main.dart';

class AppNavigator {
  static int transitionDuration = 300;

  // Slide navigation from right to left.
  static Future slide(Widget widget) {
    return Navigator.of(navigatorKey.currentContext!).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: Duration(milliseconds: transitionDuration),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        maintainState: true,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end);
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        }));
  }

  // Slide navigation from right to left.
  static Future slideReplacement(Widget widget) {
    return Navigator.of(navigatorKey.currentContext!).pushReplacement(
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => widget,
            transitionDuration: Duration(milliseconds: transitionDuration),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            maintainState: true,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end);
              var curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: curve,
              );

              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            }));
  }

  // Fade navigation from top to bottom
  static Future fade(Widget widget) {
    return Navigator.of(navigatorKey.currentContext!).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: Duration(milliseconds: transitionDuration),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        maintainState: true,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.easeInExpo;

          var tween = Tween(begin: begin, end: end);
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  static Future goTo(BuildContext context, Widget widget) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget));
  }
}
