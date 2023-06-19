import 'package:flutter/material.dart';
import 'package:quizapp/constrain.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/widgets/next_button.dart';
import 'package:quizapp/widgets/option_card.dart';
import 'package:quizapp/widgets/question_widgets.dart';
import 'package:quizapp/widgets/result_box.dart';
import 'package:quizapp/widgets/snakbar_message.dart';

import '../Models/question_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Question> _questions = [
    Question(
        id: '10',
        title: 'What is 2 + 2 ?',
        options: {'5': false, '4': true, '20': false}),
    Question(
        id: '10',
        title: 'What is 8 + 2 ?',
        options: {'10': true, '30': false, '20': false}),
    Question(
        id: '10',
        title: 'What is 2 + 1 ?',
        options: {'5': false, '30': false, '3': true}),
  ];

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;

  void nextQuestion() {
    if (index == _questions.length - 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => ResultBox(
                result: score,
                quesLength: _questions.length,
            onPressedStartOver:(){
              startOver();
            },
              ));
    } else {
      if (isPressed) {
        setState(() {
          isPressed = false;
          index++;
        });
      } else {
        showSnackBarMessage(MyApp.globalKey.currentContext!,
            'Please Select a Option', Colors.red);
      }
    }
    isAlreadySelected = false;
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        setState(() {
          score += 1;
          isPressed = true;
        });
      } else {
        setState(() {
          isPressed = true;
        });
      }
      isAlreadySelected = true;
    }
  }

   startOver()
  {
      setState(() {
        index = 0;
        score = 0;
        isPressed = false;
        isAlreadySelected = false;
      });
      Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Quiz App'),
        shadowColor: Colors.transparent,
        backgroundColor: background,
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Score $score',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            QuestinWidget(
              question: _questions[index].title,
              indexAction: index,
              totalQuestion: _questions.length,
            ),
            Divider(
              color: neutral,
            ),
            SizedBox(
              height: 25.0,
            ),
            for (int i = 0; i < _questions[index].options.length; i++)
              GestureDetector(
                onTap: () {
                  checkAnswerAndUpdate(
                      _questions[index].options.values.toList()[i]);
                },
                child: OptionCard(
                  option: _questions[index].options.keys.toList()[i],
                  color: isPressed
                      ? _questions[index].options.values.toList()[i] == true
                          ? correct
                          : inCorrect
                      : neutral,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: NextButton(
          onTap: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
