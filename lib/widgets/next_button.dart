import 'package:flutter/material.dart';
import 'package:quizapp/constrain.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: neutral,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Text('Next Question',
      textAlign: TextAlign.center ,),
    );
  }
}
