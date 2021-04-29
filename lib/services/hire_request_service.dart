import 'package:cloud_firestore/cloud_firestore.dart';

class RequestServices {
  CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');

  Future<DocumentReference> saveRequest(Map<String, dynamic> data) {
    var result = requests.add(data);
    return result;
  }
}
