import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/Models/database_connection.dart';
import 'package:quizapp/Models/question_model.dart';
import 'package:quizapp/screens/home_screens.dart';

void main()
{
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: globalKey,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

