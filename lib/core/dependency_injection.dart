import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeko_hotel_crm/core/networking/networking.dart';
import 'package:zeko_hotel_crm/features/auth/data/repository/auth_repository.dart';
import 'package:zeko_hotel_crm/features/order_management/data/repository/orders_repository.dart';
import 'package:zeko_hotel_crm/main.dart';

void injecteDependencies() {
  // Add dependencies here
  getIt.registerSingleton(HttpService(baseUrl: "http://192.168.1.19:8000"));
  getIt.registerSingletonAsync(() => SharedPreferences.getInstance());

  // Repositories

  // Auth
  getIt.registerSingleton(
      AuthRepositoryImpl(httpService: getIt.get<HttpService>()));

  // Order Management
  getIt.registerSingleton<OrderRepository>(
      OrderRepositoryImpl(httpService: getIt.get<HttpService>()));
}
