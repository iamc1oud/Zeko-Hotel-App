// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zeko_hotel_crm/features/auth/screens/auth_screens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

// Global Navigation key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final Strings = AppLocalizations.of(navigatorKey.currentContext!);
final AppMediaQuery = MediaQuery.of(navigatorKey.currentContext!);
final ThemeQuery = Theme.of(navigatorKey.currentContext!).colorScheme;
TextTheme textStyles = Theme.of(navigatorKey.currentContext!).textTheme;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      navigatorKey: navigatorKey,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: Corners.medBorder),
            isDense: true),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const LoginView(),
    );
  }
}
