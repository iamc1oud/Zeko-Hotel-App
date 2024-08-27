import 'package:flutter/material.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField().addLabel('Phone Number'),
          TextFormField().addLabel('Password'),
        ],
      ).padding(Paddings.contentPadding).centerAlign(),
    );
  }
}
