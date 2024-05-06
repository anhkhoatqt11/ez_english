import 'package:flutter/material.dart';

class LanguagePickerDialog extends StatefulWidget {
  LanguagePickerDialog({super.key, required this.selectedLanguage});
  String selectedLanguage;
  @override
  _LanguagePickerDialogState createState() {
    return _LanguagePickerDialogState();
  }
}

class _LanguagePickerDialogState extends State<LanguagePickerDialog> {
  @override
  void initState() {
    super.initState();
    _selectedIndex = languageList.indexOf(widget.selectedLanguage);
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _selectedIndex = 0;
  List<String> languageList = ['vi', 'en'];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      child: SizedBox(
        height: 200,
        child: Center(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: languageList.length,
              itemBuilder: (context, index) {
                return RadioListTile<int>(
                    value: index,
                    title: Text(languageList[index].toUpperCase()),
                    groupValue: _selectedIndex,
                    onChanged: (value) {
                      if (value == null) return;
                      if (_selectedIndex == value) return;
                      widget.selectedLanguage = languageList[value];
                      Navigator.of(context).pop(widget.selectedLanguage);
                    });
              }),
        ),
      ),
    );
  }
}
