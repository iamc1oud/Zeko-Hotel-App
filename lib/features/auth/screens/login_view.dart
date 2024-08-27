import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zeko_hotel_crm/assets.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/shared/widgets/buttons/animated_button.dart';
import 'package:zeko_hotel_crm/shared/widgets/dismiss_keyboard.dart';
import 'package:zeko_hotel_crm/shared/widgets/forms/phone_number_field.dart';
import 'package:zeko_hotel_crm/utils/extensions/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ButtonState? state;

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: FadeTransition(
              key: const ValueKey(2),
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
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
                        const PhoneNumberField(),
                        Spacing.hlg,
                        TextFormField(
                          obscureText: true,
                        ).addLabel(Strings!.password),
                        Spacing.hlg,
                        Row(
                          children: [
                            AnimatedButton(
                              state: state,
                              onPressed: () {
                                setState(() {
                                  state = ButtonState.loading;
                                });
                                Future.delayed(const Duration(seconds: 2), () {
                                  setState(() {
                                    state = ButtonState.idle;
                                  });
                                });
                              },
                              child: const Text('Login'),
                            ).expanded(),
                            Spacing.wlg,
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot password?',
                                  style: textStyles.bodySmall,
                                )),
                          ],
                        ),
                      ],
                    ).padding(Paddings.contentPadding),
                  ],
                ),
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
          bottomSheet: Image.asset(
            PlatformAssets.appLogo,
            height: 20,
            width: AppMediaQuery.size.width,
            alignment: Alignment.bottomCenter,
          ).padding(Paddings.verticalPadding)),
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
        width: AppMediaQuery.size.width,
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
