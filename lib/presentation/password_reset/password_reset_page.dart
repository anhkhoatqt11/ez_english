import 'package:ez_english/config/asset_manager.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/main.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_text_input.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  Future<void> resetPassword() async {
    // Add your code here
    try {
      setState(() {
        isLoading = true;
      });
      await supabase.auth.resetPasswordForEmail(emailController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reset password success'),
          ),
        );
        emailController.clear();
      }
    } on AuthException catch (e) {}
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
                  SizedBox(
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
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.forget_password,
                      style: getSemiBoldStyle(
                          color: ColorManager.darkSlateGrayColor, fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 5), // Added SizedBox for spacing
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.forget_password_description,
                      style: getLightStyle(
                          color: ColorManager.lightTextColor, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 40),
                  CommonTextInput(
                    controller: emailController,
                    text: AppLocalizations.of(context)!.enter_email,
                    obsucure: false,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 30),
                  CommonButton(
                    text: AppLocalizations.of(context)!.forget_password,
                    action: isLoading ? null : resetPassword,
                  )
                ]),
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
            )
          ],
        ),
      ),
    );
  }
}
