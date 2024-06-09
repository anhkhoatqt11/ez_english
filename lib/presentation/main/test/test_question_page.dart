import 'package:ez_english/domain/model/test.dart';
import 'package:ez_english/domain/model/test_question.dart';
import 'package:ez_english/presentation/blocs/test/test_bloc.dart';
import 'package:ez_english/presentation/common/objects/part_object.dart';
import 'package:ez_english/presentation/main/test/widgets/test_question_body.dart';
import 'package:ez_english/presentation/part_info/part_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestQuestionPage extends StatefulWidget {
  const TestQuestionPage(
      {super.key,
      required this.pagePartController,
      required this.part,
      required this.test,
      required this.answerMap});
  final PageController pagePartController;
  final PartObject part;
  final Test test;
  final Map<int, String> answerMap;
  @override
  State<TestQuestionPage> createState() => _TestQuestionPageState();
}

class _TestQuestionPageState extends State<TestQuestionPage> {
  PageController pageController = PageController();
  TestBloc testBloc = GetIt.instance<TestBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate = navigateToNextQuestion;
    pageController.addListener(changeFunction);
    testBloc.add(PauseCounter());
    testBloc.add(LoadTestQuestionsByPartTest(
        widget.test.id, widget.part.index, widget.part.skill));
    answerMap = widget.answerMap;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("I'm disposed");
    pageController.removeListener(changeFunction);
    pageController.dispose();
    super.dispose();
  }

  void changeFunction() {
    if (pageController.page!.round() == 2 && navigate != navigateToNextPart) {
      navigate = navigateToNextPart;
    }
  }

  void navigateToNextPart() {
    widget.pagePartController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void navigateToNextQuestion() {
    testBloc.add(ContinueCounter());
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  Map<int, String> answerMap = {};
  bool isPartInfo = true;

  Function? navigate;
  List<TestQuestion> questionList = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: questionList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return BlocConsumer<TestBloc, TestState>(
              bloc: testBloc,
              buildWhen: (previous, current) => current is QuestionState,
              listener: (context, state) {
                if (state is TestQuestionLoadedState) {
                  setState(() {
                    questionList.addAll(state.questionList);
                  });
                }
              },
              builder: (context, state) {
                if (state is TestQuestionLoadingState) {
                  return PartInfoPage(
                    isPractice: false,
                    partObject: widget.part,
                    nextButton: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is TestQuestionLoadedState) {
                  return PartInfoPage(
                      isPractice: false,
                      partObject: widget.part,
                      nextButton: FilledButton(
                          onPressed: () {
                            navigate?.call();
                          },
                          child: Text(AppLocalizations.of(context)!.got_it)));
                }
                if (state is TestQuestionErrorState) {
                  return PartInfoPage(
                      isPractice: false,
                      partObject: widget.part,
                      nextButton: Center(
                        child: Text(state.failure.toString()),
                      ));
                }
                return Container();
              },
            );
          }
          return TestQuestionBody(
              answerMap: answerMap, questionList: questionList);
        },
      ),
    );
  }
}
