import 'dart:async';

import 'package:ez_english/main.dart';
import 'package:ez_english/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EntryTestPage extends StatefulWidget {
  const EntryTestPage({super.key});

  @override
  State<EntryTestPage> createState() => _EntryTestPageState();
}

class _EntryTestPageState extends State<EntryTestPage> {
  List<Map<String, dynamic>> _questions = [];
  Map<int, int> _selectedAnswers = {};
  bool _loading = true;
  late final StreamSubscription<AuthState> authStateSubscription;
  late Session currentSession;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await Supabase.instance.client.from('entry_test_question').select();
    setState(() {
      _questions = List<Map<String, dynamic>>.from(response as List);
      _loading = false;
    });
    authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      currentSession = session!;
    });
  }

  Widget _buildTestContent() {
    return ListView.builder(
      itemCount: _questions.length,
      itemBuilder: (context, index) {
        final question = _questions[index];
        final section = question['section'];
        if (section == 'Vocabulary' &&
            question['vocabulary_question'] != null) {
          return _buildVocabularyQuestion(index, question);
        } else if (section == 'Language Use' &&
            question['language_question'] != null) {
          return _buildLanguageQuestion(index, question);
        } else if (section == 'Writing' &&
            question['writing_question'] != null) {
          return _buildWritingQuestion(index, question);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildVocabularyQuestion(int index, Map<String, dynamic> question) {
    final data = {
      'question': question['vocabulary_question'],
      'answers':
          List<String>.from(question['vocabulary_answers']?['answers'] ?? []),
      'correct_answer': question['vocabulary_answers']?['correct_answer']
    };
    return _buildQuestion(index, data);
  }

  Widget _buildLanguageQuestion(int index, Map<String, dynamic> question) {
    final data = {
      'question': question['language_question'],
      'answers':
          List<String>.from(question['language_answers']?['answers'] ?? []),
      'correct_answer': question['language_answers']?['correct_answer']
    };
    return _buildQuestion(index, data);
  }

  Widget _buildWritingQuestion(int index, Map<String, dynamic> question) {
    final data = {
      'question': question['writing_question'],
      'answers':
          List<String>.from(question['writing_answers']?['answers'] ?? []),
      'correct_answer': question['writing_answers']?['correct_answer']
    };
    return _buildQuestion(index, data);
  }

  Widget _buildQuestion(int index, Map<String, dynamic> data) {
    final questionText = data['question'];
    final answers = List<String>.from(data['answers'] ?? []);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${index + 1}. $questionText'),
              ...answers.asMap().entries.map((entry) {
                final answerIndex = entry.key;
                final answerText = entry.value;
                return RadioListTile<int>(
                  value: answerIndex,
                  groupValue: _selectedAnswers[index],
                  title: Text(answerText),
                  onChanged: (value) {
                    setState(() {
                      _selectedAnswers[index] = value!;
                    });
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  void _submitTest() async {
    int correctAnswers = 0;
    int totalQuestions = _questions.length;

    for (int i = 0; i < totalQuestions; i++) {
      final question = _questions[i];
      final section = question['section'];
      final correctAnswerIndex = _getCorrectAnswerIndex(question, section);

      if (_selectedAnswers[i] == correctAnswerIndex) {
        correctAnswers++;
      }
    }

    String level = _getLevel(correctAnswers, totalQuestions);

    switch (level) {
      case 'Beginner':
        await supabase.from('profiles').update({"level_id": 1}).eq(
            "uuid", currentSession?.user?.id as Object);
        await supabase.from("level_progress").update({
          "listening_point": 0,
          "reading_point": 0,
          "speaking_point": 0,
          "writing_point": 0
        }).eq("uuid", currentSession?.user?.id as Object);
        break;
      case 'Intermediate':
        await supabase.from('profiles').update({"level_id": 3}).eq(
            "uuid", currentSession?.user?.id as Object);
        await supabase.from("level_progress").update({
          "listening_point": 500,
          "reading_point": 500,
          "speaking_point": 500,
          "writing_point": 500,
        }).eq("uuid", currentSession?.user?.id as Object);
        break;
      case 'Advanced':
        await supabase.from('profiles').update({"level_id": 4}).eq(
            "uuid", currentSession?.user?.id as Object);
        await supabase.from("level_progress").update({
          "listening_point": 1000,
          "reading_point": 1000,
          "speaking_point": 1000,
          "writing_point": 1000
        }).eq("uuid", currentSession?.user?.id as Object);
        break;
    }

    Navigator.of(context).pushReplacementNamed(
      RoutesName.entryTestResultRoute,
      arguments: level,
    );
  }

  int _getCorrectAnswerIndex(Map<String, dynamic> question, String section) {
    switch (section) {
      case 'Vocabulary':
        return question['vocabulary_answers']?['correct_answer'] ?? -1;
      case 'Language Use':
        return question['language_answers']?['correct_answer'] ?? -1;
      case 'Writing':
        return question['writing_answers']?['correct_answer'] ?? -1;
      default:
        return -1;
    }
  }

  String _getLevel(int correctAnswers, int totalQuestions) {
    final percentage = (correctAnswers / totalQuestions) * 100;
    if (percentage >= 80) {
      return 'Advanced';
    } else if (percentage >= 50) {
      return 'Intermediate';
    } else {
      return 'Beginner';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.entry_test),
        backgroundColor: Colors.white,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(child: _buildTestContent()),
                ElevatedButton(
                  onPressed: _submitTest,
                  child: Text('Submit'),
                ),
              ],
            ),
    );
  }
}
