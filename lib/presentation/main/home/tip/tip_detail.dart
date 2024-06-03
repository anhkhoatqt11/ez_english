import 'package:ez_english/config/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';

class TipDetail extends StatelessWidget {
  final String title;
  final String content;

  const TipDetail({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
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
                Navigator.pushNamed(context, RoutesName.homeRoute);
              }
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: getBoldStyle(color: Colors.black, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          content,
                          style: getMediumStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}