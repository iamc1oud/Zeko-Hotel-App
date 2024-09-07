import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeko_hotel_crm/features/analytics/screens/analytics_screens.dart';
import 'package:zeko_hotel_crm/features/order_management/screens/order_management_screens.dart';

import '../../auth/logic/cubit/auth_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentPage = 0;

  final tabs = [
    const AnalyticsTabView(),
    const OrderManagementTabView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zeko'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Badge.count(
                  count: 10, child: const Icon(Icons.notifications)))
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            TextButton.icon(
                icon: Icon(Icons.logout_outlined),
                label: Text('Log out'),
                onPressed: () {
                  context.read<AuthCubit>().clear();
                }),
          ],
        ),
      ),
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
                icon: Icon(Icons.analytics_outlined), label: 'Analytics'),
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank_outlined), label: 'Orders')
          ]),
    );
  }
}
