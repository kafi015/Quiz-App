import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context,String titel, [Color color = Colors.blue])
{
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
        Text(titel,style: const TextStyle(fontSize: 18),),
        backgroundColor: color,
      ));
}