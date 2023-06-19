import 'package:flutter/material.dart';
import 'package:quizapp/constrain.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/widgets/next_button.dart';
import 'package:quizapp/widgets/option_card.dart';
import 'package:quizapp/widgets/question_widgets.dart';
import 'package:quizapp/widgets/result_box.dart';
import 'package:quizapp/widgets/snakbar_message.dart';

import '../Models/database_connection.dart';
import '../Models/question_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Question> _questions = [
  //   Question(
  //       id: '10',
  //       title: 'What is 2 + 2 ?',
  //       options: {'5': false, '4': true, '20': false}),
  //   Question(
  //       id: '10',
  //       title: 'What is 8 + 2 ?',
  //       options: {'10': true, '30': false, '20': false}),
  //   Question(
  //       id: '10',
  //       title: 'What is 2 + 1 ?',
  //       options: {'5': false, '30': false, '3': true}),
  // ];
  var db = DatabaseConnection();
  // db.addQuestion(Question(id: '20', title: 'What is 20 * 20?', options: {
  //   '200' : false,
  //   '300' : false,
  //   '400' : true,
  // }));

  late Future _questions;

  Future<List<Question>> getQuestions()
  {
    return db.fetchQuestion();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _questions = getQuestions();
  }

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => ResultBox(
                result: score,
                quesLength: questionLength,
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
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done)
          {
            if(snapshot.hasError)
              {
                return Center(child: Text('${snapshot.error}'),);
              }
            else if(snapshot.hasData){
              var extractedData = snapshot.data as List<Question>;
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
                        question: extractedData[index].title,
                        indexAction: index,
                        totalQuestion: extractedData.length,
                      ),
                      Divider(
                        color: neutral,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      for (int i = 0; i < extractedData[index].options.length; i++)
                        GestureDetector(
                          onTap: () {
                            checkAnswerAndUpdate(
                                extractedData[index].options.values.toList()[i]);
                          },
                          child: OptionCard(
                            option: extractedData[index].options.keys.toList()[i],
                            color: isPressed
                                ? extractedData[index].options.values.toList()[i] == true
                                ? correct
                                : inCorrect
                                : neutral,
                          ),
                        ),
                    ],
                  ),
                ),
                floatingActionButton: GestureDetector(
                  onTap: ()=>nextQuestion(extractedData.length),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: NextButton(
                    ),
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              );
            }

          }
        else
          {
            return const Center(child: CircularProgressIndicator(),);
          }
        return Center(child: Text('No Data'),);
      },

    );
  }
}
