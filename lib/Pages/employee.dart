import 'package:crud_opration/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                'Task',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(
                    labelText: 'Enter Task',
                    hintText: 'Enter Task',
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.purple)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.purple)))),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Age',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
                keyboardType: TextInputType.number,
                controller: agecontroller,
                decoration: InputDecoration(
                    labelText: 'Enter Age',
                    hintText: 'Enter Age',
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.purple)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.purple)))),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Location',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
                controller: locationcontroller,
                decoration: InputDecoration(
                    labelText: 'Enter Location',
                    hintText: 'Enter Location',
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.purple)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.purple)))),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () async {
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
                  // Navigator.of(context).pop();
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
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.purple.shade300),
                child: Center(
                  child: Text('Add',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
