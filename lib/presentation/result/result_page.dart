import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key , required this.answerMap});
  final Map<int , String> answerMap;
  @override
  _ResultPageState createState() {
    return _ResultPageState();
  }
}

class _ResultPageState extends State<ResultPage> {
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
      body: Column(
        children: [
          GradientAppBar(content: "Result"  , prefixIcon: InkWell(child: const Icon(Icons.arrow_back_ios), onTap: (){
            Navigator.pop(context);
          },),),
          Card(
            child: Row(
              children: [
                CircleAvatar(backgroundColor: ,)
              ],
            ),
          )
        ],
      )
    );
  }
}