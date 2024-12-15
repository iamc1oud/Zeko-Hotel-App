import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zeko_hotel_crm/features/auth/logic/cubit/auth_cubit.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'COMING SOON',
              style: GoogleFonts.vampiroOne(fontSize: 40),
            ).centerAlign().expanded(),
            FloatingActionButton.extended(
                onPressed: () async {
                  context.read<AuthCubit>().logout();
                },
                backgroundColor: Colors.red,
                label: const Text('Logout'),
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                )),
            Spacing.hlg,
          ],
        );
        // return Scaffold(
        //   body: GridView(
        //     padding: Paddings.contentPadding,
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 2, childAspectRatio: 2.5),
        //     children: [
        //       TextButton.icon(
        //         onPressed: () {},
        //         label: const Text('Rooms'),
        //         icon: const Icon(Icons.bed_outlined),
        //       ),
        //       TextButton.icon(
        //         onPressed: () {},
        //         label: const Text('Orders'),
        //         icon: const Icon(Icons.shopping_bag_outlined),
        //       ),
        //       TextButton.icon(
        //         onPressed: () {},
        //         label: const Text('Menus'),
        //         icon: const Icon(Icons.menu_book),
        //       ),
        //       TextButton.icon(
        //         onPressed: () {},
        //         label: const Text('Staff Management'),
        //         icon: const Icon(Icons.people_outline),
        //       ),
        //       TextButton.icon(
        //         onPressed: () {},
        //         label: const Text('Feedback'),
        //         icon: const Icon(Icons.feedback_outlined),
        //       ),
        //       TextButton.icon(
        //         onPressed: () {},
        //         label: const Text('Sliders'),
        //         icon: const Icon(Icons.campaign_outlined),
        //       ),
        //       TextButton.icon(
        //         onPressed: () {},
        //         label: const Text('Quick Links'),
        //         icon: const Icon(Icons.link),
        //       ),
        //       TextButton.icon(
        //         onPressed: () {},
        //         label: const Text('Coupons'),
        //         icon: const Icon(Icons.verified_outlined),
        //       ),
        //       TextButton.icon(
        //         onPressed: () {},
        //         label: const Text('Reservations'),
        //         icon: const Icon(Icons.book_outlined),
        //       ),
        //       TextButton.icon(
        //         onPressed: () {},
        //         label: const Text('Menu Management'),
        //         icon: const Icon(Icons.menu_outlined),
        //       ),
        //     ],
        //   ),
        //   floatingActionButton: FloatingActionButton(
        //       onPressed: () {
        //         context.read<AuthCubit>().clear();
        //       },
        //       backgroundColor: Colors.red.shade100,
        //       child: const Icon(
        //         Icons.logout_outlined,
        //         color: Colors.red,
        //       )),
        // );
      },
    );
  }
}
