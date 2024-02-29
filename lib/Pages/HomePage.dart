import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_opration/Pages/employee.dart';
import 'package:crud_opration/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getOntheLoad();
  }

  Stream? EmployeeStream;

  getOntheLoad() async {
    EmployeeStream = await DatabaseMethods().getEmployeeDetail();
    setState(() {});
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
      stream: EmployeeStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: " + ds["Name"],
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.purple.shade400,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  "Age:" + ds["Age"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Location: " + ds["Location"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: () {
                                  EditEmployeeDetail(ds["Id"]);
                                },
                                child: Icon(Icons.edit, color: Colors.purple))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Employee()));
        },
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CRUD",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(width: 5),
            Text(
              "Operation",
              style: TextStyle(
                  color: Colors.purple.shade300,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [Expanded(child: allEmployeeDetails())],
        ),
      ),
    );
  }

  Future EditEmployeeDetail(String id) => showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(20),
              height: 200,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.transparent),
                      Spacer(),
                      Text(
                        "CRUD",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Operation",
                        style: TextStyle(
                            color: Colors.purple.shade300,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.cancel, color: Colors.red))
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            Text("Delete",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.red)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(Icons.edit, color: Colors.purple.shade400),
                            Text("Edit",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.purple.shade400)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(Icons.share),
                            Text("Share", style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
}
