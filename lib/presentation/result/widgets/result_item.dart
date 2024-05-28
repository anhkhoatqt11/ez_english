import 'package:flutter/material.dart';

class ResultItem extends StatelessWidget {
  const ResultItem({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, blurRadius: 1, blurStyle: BlurStyle.outer)
          ]),
      child: child,
    );
  }
}
