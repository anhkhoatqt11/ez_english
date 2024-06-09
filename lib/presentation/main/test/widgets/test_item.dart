import 'package:ez_english/config/constants.dart';
import 'package:ez_english/config/functions.dart';
import 'package:ez_english/data/mapper/mapper.dart';
import 'package:ez_english/data/response/profile_response.dart';
import 'package:ez_english/domain/model/profile.dart';
import 'package:ez_english/domain/model/test.dart';
import 'package:ez_english/domain/usecase/get_user_profile_usecase.dart';
import 'package:ez_english/main.dart';
import 'package:ez_english/presentation/main/test/widgets/test_inherited_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/style_manager.dart';
import '../../../../utils/route_manager.dart';

class TestItem extends StatelessWidget {
  const TestItem({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final testInherited = TestInheritedWidget.of(context);
    Test testItem = testInherited!.test;
    return InkWell(
      onTap: () async {
        Profile profile = await getUserProfileById();
        bool isOK = compareLevel(
            profile.level.levelName, testItem.levelRequirement.levelName);
        if (isOK) {
          Navigator.of(context).pushNamed(RoutesName.testInformation,
              arguments: [testItem, testInherited.skills]);
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.taking_test_fail,
                maxLines: 3,
              ),
              content: Text(
                AppLocalizations.of(context)!.taking_test_fail_description,
                maxLines: 5,
              ),
            ),
          );
        }
      },
      child: Card(
        surfaceTintColor: Colors.white70,
        elevation: 4,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              width: MediaQuery.of(context).size.width * 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(testItem.name),
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            '${AppLocalizations.of(context)!.num_of_questions}: ',
                        style: getLightStyle(color: Colors.black)),
                    TextSpan(
                        text: testItem.numOfQuestions.toString(),
                        style: getRegularStyle(color: ColorManager.errorColor)),
                  ])),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '${AppLocalizations.of(context)!.minutes}: ',
                        style: getLightStyle(color: Colors.black)),
                    TextSpan(
                        text: testItem.time.toString(),
                        style: getRegularStyle(color: ColorManager.errorColor)),
                  ]))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text:
                        '${AppLocalizations.of(context)!.requirement_level}: \n',
                    style: getLightStyle(color: Colors.black)),
                TextSpan(
                    text: testItem.levelRequirement.levelName,
                    style: getBoldStyle(color: ColorManager.errorColor)),
              ])),
            ),
          ],
        ),
      ),
    );
  }

  Future<Profile> getUserProfileById() async {
    try {
      String uuid = supabase.auth.currentUser!.id;
      final response = await supabase
          .from(PROFILE_TABLE)
          .select('* , level:level_id(*)')
          .eq('uuid', uuid);
      /*final response =
          await supabaseClient.from(QUESTION_TABLE).select('* ,choice(*)');*/
      debugPrint(response.first.toString());
      ProfileResponse profileResponse =
          ProfileResponse.fromJson(response.first);
      return profileResponse.toProfile();
    } catch (e) {
      rethrow;
    }
  }
}
