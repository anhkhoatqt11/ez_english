import 'dart:async';

import 'package:ez_english/config/asset_manager.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_text_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:ez_english/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  bool redirecting = false;
  late Session? currentSession;
  int levelID = 0;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late final StreamSubscription<AuthState> authStateSubscription;

  Future<void> signIn() async {
    try {
      setState(() {
        isLoading = true;
      });

      await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login success'),
          ),
        );
        emailController.clear();
        passwordController.clear();
      }
    } on AuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred: $error'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
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
      currentSession = session;

      if (session != null) {
        fetchUserLevelID();
      }
    });
    super.initState();
  }

  Future<void> fetchUserLevelID() async {
    try {
      final response = await supabase
          .from("profiles")
          .select("level_id")
          .eq("uuid", currentSession?.user?.id as Object);

      if (response == null || response.isEmpty) {
        // Handle case where response is null or empty
        if (mounted) {
          Navigator.of(context)
              .pushReplacementNamed(RoutesName.entryTestIntroductionRoute);
        }
      } else {
        final levelId = response[0]['level_id'];
        if (levelId == null) {
          if (mounted) {
            Navigator.of(context)
                .pushReplacementNamed(RoutesName.entryTestIntroductionRoute);
          }
        } else {
          if (mounted) {
            Navigator.of(context).pushReplacementNamed(RoutesName.mainRoute);
          }
        }
      }
    } catch (error) {
      print('Error fetching user level ID: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred while fetching user level ID.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                    AppLocalizations.of(context)!.login,
                    style: getSemiBoldStyle(
                        color: ColorManager.darkSlateGrayColor, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 5), // Added SizedBox for spacing
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.login_description,
                    style: getLightStyle(
                        color: ColorManager.lightTextColor, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 40), // Added SizedBox for spacing
                CommonTextInput(
                  controller: emailController,
                  text: AppLocalizations.of(context)!.enter_email,
                  obsucure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                CommonTextInput(
                  controller: passwordController,
                  text: AppLocalizations.of(context)!.enter_password,
                  obsucure: true,
                  textInputType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 30),
                // ElevatedButton(
                //     onPressed: isLoading ? null : signIn,
                //     child: Text(AppLocalizations.of(context)!.login)),
                CommonButton(
                  text: AppLocalizations.of(context)!.login,
                  action: isLoading ? null : signIn,
                )
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
              AppLocalizations.of(context)!.move_to_register,
            ),
            InkWell(
              child: Text(
                AppLocalizations.of(context)!.register,
                style: const TextStyle(color: ColorManager.primaryColor),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(RoutesName.registerRoute);
              },
            )
          ],
        ),
      ),
    );
  }
}
