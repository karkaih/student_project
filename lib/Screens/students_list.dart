import 'package:flutter/material.dart';
import 'package:intro_to_db/Screens/student_detail.dart';
import 'package:intro_to_db/Utilities/sql_helper.dart';
import 'dart:async';
import 'package:intro_to_db/models/student.dart';
import 'package:sqflite/sqflite.dart';

class StudentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StudentsState();
  }
}

class StudentsState extends State<StudentList> {
//start working with db
  SQL_Helper helper = new SQL_Helper();

  List<Student> studentList;

// __________________________________

  int count = 0;

  @override
  Widget build(BuildContext context) {
    // initialise the operation
    if (studentList == null) {
      studentList = new List<Student>();
      updateListView();
    }
    //

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
      ),
      body: getStudentsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToStudent("Add New Student");
          updateListView();
        },
        tooltip: "ADD Student",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getStudentsList() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
              color: Colors.lightBlue.withOpacity(0.8),
              elevation: 12,
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: isPassed(this.studentList[position].pass),
                    child: getIcon(this.studentList[position].pass)),
                title: Text(this.studentList[position].name),
                subtitle: Text(this.studentList[position].desc +
                    " | " +
                    this.studentList[position].date),
                trailing: GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _delete(context, this.studentList[position]);
                  },
                ),
                onTap: () {
                  navigateToStudent("Edit Student");
                },
              ));
        });
  }

// Delete student
  void _delete(BuildContext context, Student student) async {
    int result = await helper.deleteStudent(student.id);
    if(result != 0 ){
      _showSenckBarr(context," Student has been deleted");
      // Update ListView
      updateListView();
    }


  }
//ShowsnackBar = Toast f android

  void _showSenckBarr ( BuildContext context , String msg) {

    final snackbar = SnackBar(content: Text (msg)) ;
    Scaffold.of(context).showSnackBar(snackbar);
  }
  //
  
  void updateListView() {
    final Future<Database> db = helper.initializeDatabase();
    db.then((value) {
      Future<List<Student>> students = helper.getStudentList();
      students.then((thelist) => setState ( () {
        this.studentList=thelist ;
        this.count = thelist.length;
      }));




    });
  }
// get Color
  Color isPassed(int value) {
    switch (value) {
      case 1:
        return Colors.amber;
        break;
      case 2:
        return Colors.red;
        break;

        Default:
        return Colors.amber;
    }
  }

// get Icon
  Icon getIcon(int value) {
    switch (value) {
      case 1:
        return Icon(Icons.check);
        break;
      case 2:
        return Icon(Icons.close);
        break;

      // Default : return Colors.amber ;

    }
  }

  // Navigate to other page passing name
  void navigateToStudent(String appTitle) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StudentDetail(appTitle);
    }));
  }
}
