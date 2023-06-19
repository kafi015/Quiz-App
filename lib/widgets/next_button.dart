import 'package:flutter/material.dart';
import 'package:quizapp/constrain.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: neutral,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Text('Next Question',
        textAlign: TextAlign.center ,),
      ),
    );
  }
}
