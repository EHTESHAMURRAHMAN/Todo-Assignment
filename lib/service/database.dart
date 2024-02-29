import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addEmployeeDetails(
      Map<String, dynamic> employeeinfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(employeeinfoMap);
  }

  Future<Stream<QuerySnapshot>> getEmployeeDetail() async {
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  }
}
