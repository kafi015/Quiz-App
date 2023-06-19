import 'package:flutter/material.dart';
import 'package:quizapp/screens/home_screens.dart';

void main()
{
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: globalKey,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

