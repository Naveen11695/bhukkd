import 'package:cloud_firestore/cloud_firestore.dart';

class Search_request {
   search_result(String search_query) {
     print("helo");
     return Firestore.instance
         .collection("users")
         .where("name", isEqualTo: "naveen").getDocuments();
  }

}
