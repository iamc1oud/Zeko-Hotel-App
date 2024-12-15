import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeko_hotel_crm/core/storage/storage.dart';
import 'package:zeko_hotel_crm/main.dart';

String get hotelCurrency {
  var currenyName =
      getIt.get<SharedPreferences>().getString(PrefKeys.curreny.name);

  var format = NumberFormat.simpleCurrency(name: currenyName);

  return format.currencySymbol;
}
