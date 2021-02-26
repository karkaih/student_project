import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intro_to_db/Utilities/sql_helper.dart';
import 'dart:async';
import 'package:intro_to_db/models/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intro_to_db/Screens/students_list.dart';

class StudentDetail extends StatefulWidget {
  String screenTitle;

  Student student;

  StudentDetail(this.student, this.screenTitle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Students(this.student, screenTitle);
  }
}

class Students extends State<StudentDetail> {
  static var _status = ["successed", "faild"];
  String screenTitle;

  Student student;

  SQL_Helper helper = SQL_Helper();

  Students(this.student, this.screenTitle);

  TextEditingController studentsName = new TextEditingController();
  TextEditingController studentsDetail = new TextEditingController();
  String test = "successed";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    studentsName.text = student.name;
    studentsDetail.text = student.desc;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(screenTitle),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                goBack();
              },
            ),
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
                    value: getPassing(student.pass),
                    onChanged: (selectedItem) {
                      setState(() {
                        setPatssing(selectedItem);
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
                     student.name = value ;
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
                      student.desc= value ;
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
                            _save();
                          });
                        },
                      )),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                          child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Delete",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            _delete();
                          });
                        },
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () {
          debugPrint("cllicked");
          goBack();
        });

  }

  // Save
  void _save() async{
    int result ;
 goBack() ;
 student.date = DateFormat.yMMMd().format(DateTime.now());
    if(student.id == null) {
      result = await helper.insertStudent(student) ;

    }
    else {
      result = await helper.updateStudent(student);
    }
if(result==0) {
  showAlertDialog("Sorry", "Student Not Saved");
}else{
  showAlertDialog("Conrtaulation", "Student Save");
}

//Show Alert Dialog
  }
  void showAlertDialog( String title , String msg) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      
    );
    showDialog(context : context, builder: (_)=> alertDialog);
  }


  // Insert
  void setPatssing(String value) {
    switch (value) {
      case "successed":
        student.pass = 1;
        break;
      case "faild":
        student.pass = 2;
        break;
    }
  }

  // Display
  String getPassing(int value) {
    String pass;
    switch (value) {
      case 1:
        pass = _status[0];
        break;
      case 2:
        pass = _status[1];
        break;
    }
    return pass;
  }




//Delete

void _delete() async{
  goBack();
  if(student.id == null){
    showAlertDialog("Ok Delete", "No student was deleted");
    return;

  }
  int result =await helper.deleteStudent(student.id);
 if(result == 0 ){
   showAlertDialog("Ok Delete", "No student was deleted");

 }
 else{
   showAlertDialog("Ok Delete", " student deleted");

 }

}
//Back to page precedent
void goBack() {
  Navigator.pop(context,true);
}
}