import 'package:ez_english/domain/model/test_category.dart';
import 'package:ez_english/presentation/blocs/test/test_bloc.dart';
import 'package:ez_english/presentation/common/widgets/stateless/gradient_app_bar.dart';
import 'package:ez_english/presentation/main/test/widgets/test_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestListPage extends StatefulWidget {
  const TestListPage({super.key, required this.testCategory});

  final TestCategory testCategory;

  @override
  _TestListPageState createState() {
    return _TestListPageState();
  }
}

class _TestListPageState extends State<TestListPage> {
  TestBloc testBloc = GetIt.instance<TestBloc>();

  @override
  void initState() {
    super.initState();
    testBloc.add(LoadTestsByCategory(widget.testCategory.id));
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
          GradientAppBar(
            content: widget.testCategory.name,
            prefixIcon: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
          BlocBuilder<TestBloc, TestState>(
            bloc: testBloc,
            builder: (context, state) {
              if (state is TestLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TestErrorState) {
                return Center(
                  child: Text(AppLocalizations.of(context)!.something_wrong),
                );
              }
              if (state is TestLoadedState) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: state.testList.length,
                  itemBuilder: (context, index) {
                    return TestItem(
                      testItem: state.testList[index],
                    );
                  },
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
