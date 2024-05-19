import 'package:ez_english/app_prefs.dart';
import 'package:ez_english/config/asset_manager.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/constants.dart';
import 'package:ez_english/config/functions.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/blocs/app_language/language_changing_cubit.dart';
import 'package:ez_english/presentation/common/widgets/stateful/language_picker_dialog.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/main/profile/widgets/answer_interface_dialog.dart';
import 'package:ez_english/presentation/main/profile/widgets/setting_dialog.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ez_english/main.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> signOut(BuildContext context) async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (error) {
      if (!context.mounted) return;
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      if (!context.mounted) return;
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(RoutesName.loginRoute);
      }
    }
  }

  AppPrefs appPrefs = GetIt.instance<AppPrefs>();
  late String _selectedLanguage;
  late String username, email, avatarUrl;
  @override
  void initState() {
    super.initState();
    _selectedLanguage = appPrefs.getAppLanguage() ?? DEFAULT_LANG_CODE;
    username =
        supabase.auth.currentUser?.userMetadata?['username'] ?? "No name";
    email = supabase.auth.currentUser?.email ?? "No email";
    avatarUrl = supabase.auth.currentUser?.userMetadata?['avatarUrl'] ?? '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: [
          GradientAppBar(
            content: AppLocalizations.of(context)!.profile,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(children: [
              const SizedBox(
                height: 24,
              ),
              CircleAvatar(
                radius: 111 / 2,
                backgroundImage: NetworkImage(avatarUrl),
                onBackgroundImageError: (exception, stackTrace) =>
                    const AssetImage(ImagePath.errorImagePath),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(username),
              const SizedBox(
                height: 4,
              ),
              Text(
                email,
                style: getRegularStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<AppLanguageCubit, Locale>(
                builder: (context, state) {
                  return _buildProfleItem(
                      content: AppLocalizations.of(context)!.language_option,
                      prefixIconPath: ImagePath.languageSvgPath,
                      suffix: Text(
                        state.languageCode.toUpperCase(),
                        style: getLightStyle(color: Colors.black, fontSize: 13),
                      ),
                      function: () async {
                        String? langCode = await showAnimatedDialog1(
                            context,
                            LanguagePickerDialog(
                              selectedLanguage: state.languageCode,
                            ));
                        if (langCode != null &&
                            langCode.isNotEmpty &&
                            context.mounted) {
                          context
                              .read<AppLanguageCubit>()
                              .changeLanguage(langCode);
                          appPrefs.setAppLanguage(langCode);
                        }
                      });
                },
              ),
              _buildProfleItem(
                content: AppLocalizations.of(context)!.settings,
                prefixIconPath: ImagePath.settingsSvgPath,
                function: () {
                  showAnimatedDialog1(context, const SettingDialog());
                },
              ),
              _buildProfleItem(
                content: AppLocalizations.of(context)!.answer_interface,
                prefixIconPath: ImagePath.settingsSvgPath,
                function: () {
                  showAnimatedDialog1(context, const AnswerInterfaceDialog());
                },
              ),
              _buildProfleItem(
                content: AppLocalizations.of(context)!.sign_out,
                prefixIconPath: ImagePath.signOutSvgPath,
                function: () => signOut(context),
              )
            ]),
          )
        ],
      ),
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
