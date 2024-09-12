import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeko_hotel_crm/assets.dart';
import 'package:zeko_hotel_crm/core/navigation/app_navigation.dart';
import 'package:zeko_hotel_crm/features/auth/logic/cubit/auth_cubit.dart';
import 'package:zeko_hotel_crm/features/home_screen/screens/bottom_navigation_bar.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/shared/widgets/buttons/animated_button.dart';
import 'package:zeko_hotel_crm/shared/widgets/dismiss_keyboard.dart';
import 'package:zeko_hotel_crm/shared/widgets/forms/phone_number_field.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Form text controllers
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();

    SchedulerBinding.instance.addPostFrameCallback((v) {
      final authCubit = BlocProvider.of<AuthCubit>(context);

      if (authCubit.state.isSignedIn == true) {
        AppNavigator.slideReplacement(const HomeScreen());
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return DismissKeyboard(
      child: Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: FadeTransition(
              key: const ValueKey(2),
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                    return Form(
                      key: authCubit.loginFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _LogoWithGradient(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Enter your mobile number",
                                style: textStyles.titleLarge,
                              ),
                              Spacing.hlg,
                              PhoneNumberField(onChanged: (phoneNumber) {
                                authCubit.phoneNumberController.text =
                                    phoneNumber;
                              }),
                              Spacing.hlg,
                              TextFormField(
                                controller: authCubit.passwordController,
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return 'Password is required';
                                  }
                                  return null;
                                },
                                obscureText: true,
                              ).addLabel(Strings!.password),
                              Spacing.hlg,
                              AnimatedButton(
                                state: authState.loadingState,
                                onPressed: () async {
                                  authCubit.loginStaff();
                                },
                                child: const Text(
                                  'Login',
                                ),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot password?',
                                    style: textStyles.bodySmall,
                                  ))
                            ],
                          ).padding(Paddings.contentPadding),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          bottomSheet: SizedBox(
            height: 40,
            child: Center(
              child: Image.asset(
                PlatformAssets.appLogo,
                height: 20,
                alignment: Alignment.center,
              ).padding(Paddings.verticalPadding),
            ),
          )),
    );
  }
}

class _LogoWithGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Container(
        height: AppMediaQuery.size.height * 0.3,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(PlatformAssets.loginbanner),
          ),
        ),
      ),
    );
  }
}
