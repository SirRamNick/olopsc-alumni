import 'package:flutter/material.dart';

class QuestionForm extends StatelessWidget {
  final Widget content;
  const QuestionForm({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 300, right: 300, top: 25),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: content,
      ),
    );
  }
}
