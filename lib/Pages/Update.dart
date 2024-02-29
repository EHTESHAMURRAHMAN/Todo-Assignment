import 'package:crud_opration/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

// ignore: must_be_immutable
class EmployeeUpdate extends StatefulWidget {
  String id;
  String name;
  String age;
  String location;
  EmployeeUpdate(
      {required this.id,
      required this.name,
      required this.age,
      required this.location,
      super.key});

  @override
  State<EmployeeUpdate> createState() => _EmployeeUpdateState();
}

class _EmployeeUpdateState extends State<EmployeeUpdate> {
  @override
  void initState() {
    super.initState();
    namecontroller.text = widget.name;
    agecontroller.text = widget.age;
    locationcontroller.text = widget.location;
  }

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
              "Update",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w200),
            ),
            SizedBox(width: 5),
            Text(
              "Form",
              style: TextStyle(
                  color: Colors.purple.shade200,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Name',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(
                    labelText: 'Enter Name',
                    hintText: 'Enter Name',
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
                Map<String, dynamic> updateInfo = {
                  "Name": namecontroller.text,
                  "Id": id,
                  "Age": agecontroller.text,
                  "Location": locationcontroller.text
                };
                await DatabaseMethods()
                    .addEmployeeDetails(updateInfo, widget.id)
                    .then((value) {
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Employee Dtatails has been Updated successfully",
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
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple.shade300),
                child: Center(
                  child: Text('Update',
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
