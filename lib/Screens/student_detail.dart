import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_to_db/Utilities/sql_helper.dart';
import 'dart:async';
import 'package:intro_to_db/models/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intro_to_db/Screens/students_list.dart';


class StudentDetail extends StatefulWidget {
  String screenTitle ;
  StudentDetail(this.screenTitle);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Students(screenTitle);
  }
}

class Students extends State<StudentDetail> {
  static var _status = {"successed", "faild"};
  String screenTitle ;
  Students(this.screenTitle);
  TextEditingController studentsName = new TextEditingController();
  TextEditingController studentsDetail = new TextEditingController();
String test ="successed";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return WillPopScope(child:  Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
        leading: IconButton(icon:Icon (Icons.arrow_back) ,
          onPressed:(){
            goBack();
          } ,),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: ListView(
          children: [
            ListTile(
              title: DropdownButton(
                items: _status.map((String dropdownItem) {
                  return DropdownMenuItem<String>(
                    value: dropdownItem,
                    child: Text(dropdownItem),
                  );
                }).toList(),
                style: textStyle,
                value:test,
                onChanged: (selectedItem) {
                  setState(() {
                    test = selectedItem;
                    debugPrint("User Select $selectedItem");
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: TextField(
                controller: studentsName,
                style: textStyle,
                onChanged: (value) {
                  debugPrint("User Edit The Name");
                },
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: TextField(
                controller: studentsDetail,
                style: textStyle,
                onChanged: (value) {
                  debugPrint("User Edit The Description");
                },
                decoration: InputDecoration(
                  labelText: "Description :",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                children: [
                  Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Save",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("User Click Saved");
                          });
                        },
                      )),Container(width: 5.0,),Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Delete",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("User Click Delete");
                          });
                        },
                      ))
                ],
              ),
            ),

          ],
        ),
      ),
    ), onWillPop: (){
      debugPrint("cllicked");
      goBack();
    }) ;
  }


  void goBack () {
    Navigator.pop(context);
  }
}
