import 'package:final_project/HomePage.dart';
import 'package:final_project/LoginPage.dart';
import 'package:final_project/Robot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(ChangeNotifierProvider(
      create: (context) {
        return MyStore();
      },
      child: MaterialApp(home: LoginPage())));
}
