import 'package:flutter/material.dart';
import 'dart:async' ;

import 'Screens/students_list.dart';

void main() {
runApp(MyApp());
  print("start the Application");
  getFileContent();
  print ("End The Application");
}

getFileContent() async{

 String filecontent = await downloadFile();
  print(filecontent);
}

Future downloadFile() {
  Future<String> content =  Future.delayed(Duration(seconds: 3), () {
    return "Internet File Content" ;

  }) ;
return content ;
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Student List",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: StudentList(),
    );
  }
}
