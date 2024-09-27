import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeko_hotel_crm/core/networking/networking.dart';
import 'package:zeko_hotel_crm/features/analytics/data/repository/analytics_repository.dart';
import 'package:zeko_hotel_crm/features/auth/data/repository/auth_repository.dart';
import 'package:zeko_hotel_crm/features/order_management/data/repository/orders_repository.dart';
import 'package:zeko_hotel_crm/main.dart';

Future injecteDependencies() async {
  getIt.registerSingletonAsync(() => SharedPreferences.getInstance());

  // Add dependencies here
  getIt.registerSingleton(HttpService(baseUrl: "http://192.168.1.10:8000"));
  // getIt.registerSingleton(HttpService(baseUrl: "https://dev.zeko.tech"));

  // Repositories

  // Auth
  getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(httpService: getIt.get<HttpService>()));

  // Analytics
  getIt.registerSingleton<AnalyticsRepository>(
      AnalyticsRepositoryImpl(httpService: getIt.get<HttpService>()));

  // Order Management
  getIt.registerSingleton<OrderRepository>(
      OrderRepositoryImpl(httpService: getIt.get<HttpService>()));
}
