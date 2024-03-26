import 'package:ez_english/config/asset_manager.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateful/language_picker_dialog.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _selectedLanguage = "EN";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        GradientAppBar(
          content: AppLocalizations.of(context)!.profile,
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                const CircleAvatar(
                  radius: 111 / 2,
                  backgroundColor: ColorManager.primaryColor,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text('User name'),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '216354@gm.uit.edu.vn',
                  style: getRegularStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 16,
                ),
                _buildProfleItem(
                    content: AppLocalizations.of(context)!.language_option,
                    prefixIconPath: ImagePath.languageSvgPath,
                    suffix: Text(
                      _selectedLanguage,
                      style: getLightStyle(color: Colors.black, fontSize: 13),
                    ),
                    function: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return LanguagePickerDialog(
                            selectedLanguage: _selectedLanguage,
                          );
                        },
                      );
                    }),
                _buildProfleItem(
                    content: AppLocalizations.of(context)!.settings,
                    prefixIconPath: ImagePath.settingsSvgPath),
                _buildProfleItem(
                    content: AppLocalizations.of(context)!.sign_out,
                    prefixIconPath: ImagePath.signOutSvgPath),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProfleItem(
      {required String prefixIconPath,
      required String content,
      Widget? suffix,
      void Function()? function}) {
    return InkWell(
      onTap: function,
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: ListTile(
          title: Text(content),
          leading: SvgPicture.asset(prefixIconPath),
          trailing: suffix,
        ),
      ),
    );
  }
}
