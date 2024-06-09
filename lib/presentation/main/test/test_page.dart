import 'package:ez_english/config/color_manager.dart';
import 'package:ez_english/config/style_manager.dart';
import 'package:ez_english/domain/model/test.dart';
import 'package:ez_english/domain/model/test_category.dart';
import 'package:ez_english/presentation/blocs/test/test_bloc.dart';
import 'package:ez_english/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/main/test/widgets/test_inherited_widget.dart';
import 'package:ez_english/presentation/main/test/widgets/test_item.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() {
    return _TestPageState();
  }
}

class _TestPageState extends State<TestPage> {
  TestBloc testBloc = GetIt.instance<TestBloc>();
  @override
  void initState() {
    super.initState();
    testBloc.add(LoadTestCategory());
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
          child: BlocConsumer<TestBloc, TestState>(
            bloc: testBloc,
            buildWhen: (previous, current) => current is CategoryState,
            listener: (context, state) {
              if (state is TestErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    content: Text(state.failure.toString())));
              }
            },
            builder: (context, state) {
              if (state is TestCategoryLoadedState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ...state.testCategoryList.map(
                        (e) => Column(
                          children: [
                            _buildTestTitle(context, e),
                            const SizedBox(
                              height: 8,
                            ),
                            _buildTestList(e),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              if (state is TestCategoryLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TestCategoryErrorState) {
                return Center(
                  child: Text(AppLocalizations.of(context)!.something_wrong),
                );
              }
              return Container();
            },
          ),
        ))
      ],
    );
  }

  Widget _buildTestList(TestCategory testCategory) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: testCategory.testList.length,
      itemBuilder: (context, index) {
        return TestInheritedWidget(
          test: testCategory.testList[index],
          skills: testCategory.skills,
          child: const TestItem(),
        );
      },
    );
  }

  Widget _buildTestTitle(BuildContext context, TestCategory testCategory) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              testCategory.name,
              style: getSemiBoldStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.testListRoute,
                  arguments: testCategory);
            },
            child: Text(AppLocalizations.of(context)!.see_more,
                style: getSemiBoldStyle(
                        color: ColorManager.primaryColor, fontSize: 10)
                    .copyWith(decoration: TextDecoration.underline)),
          )
        ],
      ),
    );
  }
}
