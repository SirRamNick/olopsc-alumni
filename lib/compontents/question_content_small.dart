import 'package:flutter/material.dart';

class QuestionContentSmall extends StatelessWidget {
  final String constructQuestion;
  final Widget contructFormQuestion;
  const QuestionContentSmall({
    super.key,
    required this.constructQuestion,
    required this.contructFormQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              constructQuestion,
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: contructFormQuestion,
          )
        ],
      ),
    );
  }
}
