import 'package:flutter/material.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/main.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/common_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewTipPage extends StatelessWidget {
  const NewTipPage({Key? key}) : super(key: key);

  Future<void> updateTip(String title, String content) async {
    await supabase.
    from('tip').
    insert({
      'created_by': supabase.auth.currentUser!.id,
      'title': title,
      'content': content,
    });
  }

  @override
  Widget build(BuildContext context) {
    late String title;
    late String content;

    return Scaffold(
      body: Column(
        children: <Widget>[
          GradientAppBar(
            content: '',
            prefixIcon: InkWell(
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
              }
            ),
          ),
          // title and content input
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.title,
                          style: getMediumStyle(color: Colors.black, fontSize: 16)
                        ),
                        const SizedBox(height: 10),         
                        TextField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            title = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.content,
                          style: getMediumStyle(color: Colors.black, fontSize: 16)
                        ),
                        const SizedBox(height: 10),
                        //textfield expand when user type long content
                        TextField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            content = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          CommonButton(
            text: "OK", 
            action: () async {
              await updateTip(title, content);
              Navigator.pushNamed(context, RoutesName.homeRoute);
            }
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}