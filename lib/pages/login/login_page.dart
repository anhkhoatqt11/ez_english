import 'package:ez_english/utils/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.login,
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.registerRoute);
          },
          child: Text(
            AppLocalizations.of(context)!.login,
          ),
        ),
      ),
    );
  }
}
