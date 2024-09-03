import 'package:flutter/material.dart';
import 'package:zeko_hotel_crm/features/analytics/screens/analytics_screens.dart';
import 'package:zeko_hotel_crm/features/order_management/screens/order_management_screens.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/shared/widgets/curved_bottom_nav/curved_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  var _currentPage = 0;

  final tabs = [
    const AnalyticsTabView(),
    const OrderManagementTabView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zeko'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Badge.count(count: 10, child: Icon(Icons.notifications)))
        ],
      ),
      drawer: Drawer(),
      body: tabs.elementAt(_currentPage),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPage,
          onTap: (page) {
            setState(() {
              _currentPage = page;
            });
          },
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics), label: 'Analytics'),
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank), label: 'Orders')
          ]),
    );
  }
}
