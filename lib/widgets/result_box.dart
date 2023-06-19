import 'package:flutter/material.dart';
import 'package:quizapp/constrain.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({Key? key, required this.result, required this.quesLength, required this.onPressedStartOver,})
      : super(key: key);
  final int result;
  final int quesLength;
  final VoidCallback onPressedStartOver;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Result',
              style: TextStyle(color: neutral, fontSize: 22.0),
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 60.0,
              backgroundColor: result == quesLength / 2
                  ? Colors.yellow
                  : result < quesLength / 2
                      ? inCorrect
                      : correct,
              child: Text(
                '$result/$quesLength',
                style: const TextStyle(
                    color: neutral,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              result == quesLength / 2 ? 'Almost There' : result < quesLength / 2 ? 'Try Again?' : 'Great',
              style: const TextStyle(color: neutral, fontSize: 22.0),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Your progress: ${result * 100 ~/ quesLength}%',
              style: const TextStyle(color: neutral, fontSize: 22.0),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: background,
              ),
              onPressed: onPressedStartOver,
              child: const Text(
                'Start Over',
                style: TextStyle(color: neutral, fontSize: 22.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
