import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_opration/Pages/Update.dart';
import 'package:crud_opration/Pages/employee.dart';
import 'package:crud_opration/service/database.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Task: ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.purple.shade400,
                                        fontWeight: FontWeight.w500),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: ds["Name"],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      editEmployeeDetail(ds["Id"], ds["Name"],
                                          ds["Age"], ds["Location"]);
                                    },
                                    child:
                                        Icon(Icons.edit, color: Colors.purple))
                              ],
                            ),
                            SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                text: "Date: ",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.purple.shade400,
                                    fontWeight: FontWeight.w500),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ds["Age"],
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                            SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                text: "Description: ",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.purple.shade400,
                                    fontWeight: FontWeight.w500),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ds["Location"],
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
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
              "TODO",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(width: 5),
            Text(
              "Assignment",
              style: TextStyle(
                  color: Colors.purple.shade300,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "TODO",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(width: 5),
                Text(
                  "List",
                  style: TextStyle(
                      color: Colors.purple.shade300,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 10),
            Expanded(child: allEmployeeDetails())
          ],
        ),
      ),
    );
  }

  Future editEmployeeDetail(String id, name, age, location) => showDialog(
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
                        "TODO",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Assignment",
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
                        onTap: () async {
                          Navigator.of(context).pop();
                          await DatabaseMethods().deleteEmployeeDetails(id);
                        },
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
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmployeeUpdate(
                                        name: name,
                                        location: location,
                                        age: age,
                                        id: id,
                                      )));
                        },
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
                        onTap: () {
                          Share.share("$name\n$age\n$location");
                        },
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
