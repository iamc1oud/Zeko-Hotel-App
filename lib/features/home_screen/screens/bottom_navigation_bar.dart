import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zeko_hotel_crm/features/analytics/screens/analytics_screens.dart';
import 'package:zeko_hotel_crm/features/home_screen/screens/home_page_drawer.dart';
import 'package:zeko_hotel_crm/features/order_management/screens/order_management_screens.dart';
import 'package:zeko_hotel_crm/features/order_management/screens/orders_history/order_history_list_view.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

import '../../auth/logic/cubit/auth_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentPage = 0;

  final FlutterLocalNotificationsPlugin orderNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    context.read<AuthCubit>().getHotelDetails();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');

    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    orderNotificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: handleNotificationAction);

    // Foreground notification
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        orderNotificationPlugin.show(
            message.notification.hashCode,
            message.notification?.title,
            message.notification?.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    icon: 'launch_background',
                    colorized: true,
                    actions: [
                  // const AndroidNotificationAction('accept_order', 'Accept',
                  //     showsUserInterface: true, titleColor: Colors.green),
                  // const AndroidNotificationAction('reject_order', 'Reject',
                  //     showsUserInterface: true)
                ])));
      }
    });
    super.initState();
  }

  void handleNotificationAction(
      NotificationResponse notificationResponse) async {
    final String? actionId = notificationResponse.actionId;

    if (actionId == 'accept_order') {
      // Call the API when the "Accept" button is clicked
      logger.d("Accept Order API");
    } else if (actionId == 'reject_order') {
      // Call the API when the "Reject" button is clicked
      logger.d("Reject Order API");
    }
  }

  final tabs = [
    const AnalyticsTabView(),
    const OrderManagementTabView(),
    const AppDrawer()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                '${authState.hotelDetails?.detail?.hotelName}',
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                    icon: const Icon(Icons.logout_outlined)),
              ],
              bottom:
                  const TabBar(indicatorSize: TabBarIndicatorSize.label, tabs: [
                Tab(
                  child: Text('Manager Orders'),
                ),
                Tab(
                  child: Text('Order History'),
                )
              ]),
            ),
            body: const TabBarView(
              children: [OrderManagementTabView(), OrderHistoryListView()],
            ),
          ),
        );
      },
    );
  }
}
