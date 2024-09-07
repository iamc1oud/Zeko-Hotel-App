import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeko_hotel_crm/features/auth/logic/cubit/auth_cubit.dart';
import 'package:zeko_hotel_crm/features/order_management/screens/list_orders/order_item_card.dart';
import 'package:zeko_hotel_crm/shared/widgets/widgets.dart';
import 'package:zeko_hotel_crm/utils/extensions/extension.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        var hotelDetails = authState.hotelDetails?.detail;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.0,
                    colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds);
                },
                child: AppImage(
                  src: hotelDetails?.hotelLogo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Rooms'),
              icon: const Icon(Icons.bed_outlined),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Orders'),
              icon: const Icon(Icons.shopping_bag_outlined),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Menus'),
              icon: const Icon(Icons.menu_book),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Staff Management'),
              icon: const Icon(Icons.people_outline),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Feedback'),
              icon: const Icon(Icons.feedback_outlined),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Sliders'),
              icon: const Icon(Icons.campaign_outlined),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Quick Links'),
              icon: const Icon(Icons.link),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Coupons'),
              icon: const Icon(Icons.verified_outlined),
            ),
            const Divider(),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Reservations'),
              icon: const Icon(Icons.book_outlined),
            ),
            const Divider(),
            TextButton.icon(
              onPressed: () {},
              label: const Text('Menu Management'),
              icon: const Icon(Icons.menu_outlined),
            ),
            const Divider(),
            const Spacer(),
            TextButton.icon(
                icon: const Icon(Icons.logout_outlined),
                label: const Text('Log out'),
                onPressed: () {
                  context.read<AuthCubit>().clear();
                }).centerAlign(),
          ],
        );
      },
    );
  }
}
