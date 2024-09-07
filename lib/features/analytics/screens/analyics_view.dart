import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeko_hotel_crm/features/auth/logic/cubit/auth_cubit.dart';

class AnalyticsTabView extends StatelessWidget {
  const AnalyticsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Text('${state.hotelDetails?.detail?.currency}'),
        );
      },
    );
  }
}
