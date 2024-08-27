import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zeko_hotel_crm/features/auth/screens/auth_screens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Global Navigation key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// ignore: non_constant_identifier_names
final Strings = AppLocalizations.of(navigatorKey.currentContext!);

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
      locale: const Locale('es'),
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const LoginView(),
    );
  }
}
