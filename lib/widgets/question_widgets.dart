import 'package:flutter/cupertino.dart';

import '../constrain.dart';

class QuestinWidget extends StatelessWidget {
  const QuestinWidget({
    Key? key,
    required this.question,
    required this.indexAction,
    required this.totalQuestion,
  }) : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Question ${indexAction + 1}/$totalQuestion: $question',
        style: TextStyle(
          fontSize: 24.0,
          color: neutral,
        ),
      ),
    );
  }
}
