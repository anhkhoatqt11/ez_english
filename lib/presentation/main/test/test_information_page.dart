import 'package:ez_english/config/asset_manager.dart';
import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestInformationPage extends StatefulWidget {
  const TestInformationPage({super.key});

  @override
  _TestInformationPageState createState() {
    return _TestInformationPageState();
  }
}

class _TestInformationPageState extends State<TestInformationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test 1'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 177,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                        image: AssetImage(ImagePath.testPath),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: 8,
              ),
              Card(
                child: Wrap(
                  children: [
                    _buildIconText(
                        content:
                            '120 ${AppLocalizations.of(context)!.questions}',
                        iconPath: ImagePath.timerSvgPath),
                    _buildIconText(
                        content: 'Intermediate',
                        iconPath: ImagePath.testLevelSvgPath),
                    _buildIconText(
                        content: '120 ${AppLocalizations.of(context)!.minutes}',
                        iconPath: ImagePath.questionSvgPath),
                  ],
                ),
              ),
              Card(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.about_test,
                        style: getBoldStyle(color: Colors.black, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'sdfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffLorem ipsum dolor sit amet consectetur. Cras habitasse tempus consequat faucibus habitasse dictum elementum nulla. Pellentesque sed consectetur nulla a pretium fames elementum. Etiam amet adipiscing proin sodales hac sed massa. Pretium maecenas ipsum tortor ac adipiscing.',
                        maxLines: 50,
                        style: getLightStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(bottom: 4),
          height: 48,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
              gradient: ColorManager.linearGradientPrimary,
              borderRadius: BorderRadius.circular(30)),
          child: Center(child: Text(AppLocalizations.of(context)!.take_test)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildIconText({required String content, required String iconPath}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5 - 12,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            colorFilter: const ColorFilter.mode(
                ColorManager.primaryColor, BlendMode.srcIn),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            content,
            style: getRegularStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
