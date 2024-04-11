import 'dart:async';

import 'package:ez_english/config/asset_manager.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_text_input.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ez_english/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  bool redirecting = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late final StreamSubscription<AuthState> authStateSubscription;

  Future<void> signUp() async {
    try {
      setState(() {
        isLoading = true;
      });

      await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Signup success'),
          ),
        );
        emailController.clear();
        passwordController.clear();
        Navigator.of(context).pushReplacementNamed(RoutesName.loginRoute);
      }
    } on AuthException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (redirecting) return;
      final session = data.session;
      if (session != null) {
        redirecting = true;
        Navigator.of(context).pushReplacementNamed(RoutesName.mainRoute);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(15.0),
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.secondaryColor
                        .withOpacity(0.2), // Background color
                  ),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(ImagePath.logoPath),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40), // Added SizedBox for spacing
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.register,
                    style: getSemiBoldStyle(
                        color: ColorManager.darkSlateGrayColor, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 5), // Added SizedBox for spacing
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.register_description,
                    style: getLightStyle(
                        color: ColorManager.lightTextColor, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 40), // Added SizedBox for spacing
                // CommonTextInput(
                //   controller: usernameController,
                //   text: AppLocalizations.of(context)!.enter_username,
                //   obsucure: false,
                //   textInputType: TextInputType.text,
                // ),
                // const SizedBox(height: 20),
                CommonTextInput(
                  controller: emailController,
                  text: AppLocalizations.of(context)!.enter_email,
                  obsucure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20), // Added SizedBox for spacing
                CommonTextInput(
                  controller: passwordController,
                  text: AppLocalizations.of(context)!.enter_password,
                  obsucure: true,
                  textInputType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 30),
                // CommonButton(text: AppLocalizations.of(context)!.register),
                ElevatedButton(
                    onPressed: isLoading ? null : signUp,
                    child: Text(AppLocalizations.of(context)!.register))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.move_to_login,
            ),
            InkWell(
              child: Text(
                AppLocalizations.of(context)!.login,
                style: const TextStyle(color: ColorManager.primaryColor),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(RoutesName.loginRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
