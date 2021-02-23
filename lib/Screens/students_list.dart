import 'package:flutter/material.dart';
import 'package:intro_to_db/Screens/student_detail.dart';

class StudentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StudentsState();
  }
}

class StudentsState extends State<StudentList> {

  int count = 5;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
      ),
      body: getStudentsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToStudent("Add New Student");
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
              elevation:12,
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.amber, child: Icon(Icons.check)),
                title: Text("The first student"),
                subtitle: Text("data from this Student"),
                trailing: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onTap: () {
                  navigateToStudent("Edit Student")  ;              },
              ));
        });
  }

  void navigateToStudent(String appTitle) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StudentDetail(appTitle);
    }));
  }
}
