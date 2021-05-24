import 'package:flutter/material.dart';
import 'mainMenu/mainMenu.dart';

//Description : Start point of application
//Coded by Vignesh
void main() {
  //Description : Setting the theme color
  //Coded by Vignesh
  const PrimaryColor = Colors.pinkAccent;

  //Description : Home of application
  //Coded by Vignesh
  runApp(MaterialApp(
    title: "Sally Beauty",
    theme: ThemeData(primaryColor: PrimaryColor),
    debugShowCheckedModeBanner: false,
    home: new Menu(),
  ));
}
