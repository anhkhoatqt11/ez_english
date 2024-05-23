import 'package:ez_english/app_prefs.dart';
import 'package:ez_english/config/asset_manager.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

class AnswerInterfaceDialog extends StatefulWidget {
  const AnswerInterfaceDialog({super.key});

  @override
  _AnswerInterfaceDialogState createState() {
    return _AnswerInterfaceDialogState();
  }
}

class _AnswerInterfaceDialogState extends State<AnswerInterfaceDialog> {
  @override
  void initState() {
    super.initState();
    groupValue = appPrefs.getHorizontalAnswerBarLayout() ?? false ? 0 : 1;
  }

  late int groupValue;
  @override
  void dispose() {
    super.dispose();
  }

  final appPrefs = GetIt.instance<AppPrefs>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorManager.primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                      child: Text(
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    AppLocalizations.of(context)!.ask_answer_interface,
                    style: getBoldStyle(
                        color: ColorManager.whiteColor, fontSize: 20),
                  )),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.highlight_remove_rounded,
                      color: ColorManager.whiteColor,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.5,
              child: SingleChildScrollView(
                child: Column(
                  //shrinkWrap: true,
                  children: [
                    RadioMenuButton(
                        value: 0,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value!;
                            appPrefs.setHorizontalAnswerBarLayout(true);
                          });
                        },
                        child: SizedBox(
                          width: width * 0.7,
                          child: Text(
                            maxLines: 5,
                            AppLocalizations.of(context)!.bottom_screen,
                            style: getSemiBoldStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        maxLines: 5,
                        AppLocalizations.of(context)!
                            .recommend_answer_interface,
                        style:
                            getRegularStyle(color: ColorManager.lightTextColor),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(border: Border.all()),
                        child: Image.asset(ImagePath.horizontalAnswerPath)),
                    RadioMenuButton(
                        value: 1,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value!;
                            appPrefs.setHorizontalAnswerBarLayout(false);
                          });
                        },
                        child: SizedBox(
                            width: width * 0.7,
                            child: Text(
                              AppLocalizations.of(context)!.above_question,
                              style: getSemiBoldStyle(
                                  color: Colors.black, fontSize: 20),
                              maxLines: 5,
                            ))),
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Image.asset(ImagePath.verticalAnswerPath),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ));
  }
}
