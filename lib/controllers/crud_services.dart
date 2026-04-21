import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudServices {
  User? user = FirebaseAuth.instance.currentUser;

  Future addNewContacts(String name, String phone, String email) async {
    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "phone": phone,
    };
    try{
      await FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("contacts").add(data);
      print("Document Added");
    } catch (e) {
      return e.toString();
    }
  }

  Stream<QuerySnapshot> getContacts({String? searchQuery}) async* {
    var contactsQuery = FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("contacts").orderBy("name");

    if (searchQuery != null && searchQuery.isNotEmpty) {
      String searchEnd = searchQuery + "\uf8ff";
      contactsQuery = contactsQuery.where("name", isGreaterThanOrEqualTo: searchQuery, isLessThan: searchEnd);
    }

    var contacts = contactsQuery.snapshots();
    yield* contacts;
  }

  Future updateContact(String docId, String name, String phone, String email) async {
    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "phone": phone,
    };
    try{
      await FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("contacts").doc(docId).update(data);
      print("Document Updated");
    } catch (e) {
      return e.toString();
    }
  }

  Future deleteContact(String docId) async {
    try{
      await FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("contacts").doc(docId).delete();
      print("Document Deleted");
    } catch (e) {
      return e.toString();
    }
  }
}
