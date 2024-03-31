import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() {
    return _TestPageState();
  }
}

class _TestPageState extends State<TestPage> {
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
    return Column(
      children: [
        GradientAppBar(content: AppLocalizations.of(context)!.test),
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 12),
          child: Column(
            children: [
              _buildTestTitle(context),
              const SizedBox(
                height: 8,
              ),
              _buildTestList(),
            ],
          ),
        ))
      ],
    );
  }

  Widget _buildTestList() {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 15,
          itemBuilder: (context, index) {
            return _buildTestItem(context);
          },
        ),
      ),
    );
  }

  Widget _buildTestItem(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RoutesName.testInformation);
      },
      child: Card(
        surfaceTintColor: Colors.white70,
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(14),
          width: MediaQuery.of(context).size.width,
          height: 105,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title'),
              Text('description'),
              const Spacer(),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${AppLocalizations.of(context)!.status}: ',
                    style: getLightStyle(color: Colors.black)),
                TextSpan(
                    text: 'Not started',
                    style: getLightStyle(color: ColorManager.errorColor))
              ]))
            ],
          ),
        ),
      ),
    );
  }

  Row _buildTestTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            'TOEIC Listening & Reading Fulltest | 50',
            style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
          ),
        ),
        Text(AppLocalizations.of(context)!.see_more,
            style:
                getSemiBoldStyle(color: ColorManager.primaryColor, fontSize: 10)
                    .copyWith(decoration: TextDecoration.underline))
      ],
    );
  }
}
