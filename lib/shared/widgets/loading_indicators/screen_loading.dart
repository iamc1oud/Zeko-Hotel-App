import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zeko_hotel_crm/assets.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(LottieAssets.loading, height: 120, width: 120));
  }
}
