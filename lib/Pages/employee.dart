import 'package:crud_opration/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Employee",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(width: 5),
            Text(
              "Form",
              style: TextStyle(
                  color: Colors.purple.shade300,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                    hintText: 'Enter Name', border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Age',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: TextField(
                controller: agecontroller,
                decoration: InputDecoration(
                    hintText: 'Enter Age', border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Location',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: TextField(
                controller: locationcontroller,
                decoration: InputDecoration(
                    hintText: 'Enter Location', border: InputBorder.none),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (namecontroller.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Enter Name', gravity: ToastGravity.TOP);
                    return;
                  }
                  if (agecontroller.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Enter Age', gravity: ToastGravity.TOP);
                    return;
                  }
                  if (locationcontroller.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Enter Location', gravity: ToastGravity.TOP);
                    return;
                  }

                  String id = randomAlphaNumeric(10);
                  Map<String, dynamic> employeeinfoMap = {
                    "Name": namecontroller.text,
                    "Id": id,
                    "Age": agecontroller.text,
                    "Location": locationcontroller.text
                  };
                  await DatabaseMethods()
                      .addEmployeeDetails(employeeinfoMap, id)
                      .then((value) {
                    Fluttertoast.showToast(
                        msg: "Employee Dtatails has been added successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
                },
                child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
