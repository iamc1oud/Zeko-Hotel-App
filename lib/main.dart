// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zeko_hotel_crm/core/core.dart';
import 'package:zeko_hotel_crm/features/auth/data/repository/auth_repository.dart';
import 'package:zeko_hotel_crm/features/auth/logic/cubit/auth_cubit.dart';
import 'package:zeko_hotel_crm/features/auth/screens/auth_screens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

// Global Navigation key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final Strings = AppLocalizations.of(navigatorKey.currentContext!);
final AppMediaQuery = MediaQuery.of(navigatorKey.currentContext!);
final ThemeQuery = Theme.of(navigatorKey.currentContext!).colorScheme;
TextTheme textStyles = Theme.of(navigatorKey.currentContext!).textTheme;

// Global service locator
GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  // Load DI
  injecteDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) =>
              AuthCubit(authRepository: getIt.get<AuthRepositoryImpl>())),
    ],
    child: const ZekoApp(),
  ));
}

class ZekoApp extends StatelessWidget {
  const ZekoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Zeko',
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
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        outlinedButtonTheme: const OutlinedButtonThemeData(
            style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: Corners.smBorder)))),
        filledButtonTheme: const FilledButtonThemeData(
            style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: Corners.smBorder)))),
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: Corners.medBorder),
            isDense: true),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            const DropdownAlert(),
          ],
        );
      },
      home: const LoginView(),
    );
  }
}
