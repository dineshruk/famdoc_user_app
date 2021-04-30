import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AddServices {
  CollectionReference add = FirebaseFirestore.instance.collection('add');
  User user = FirebaseAuth.instance.currentUser;

  Future<void> addToBuy(document) {
    add.doc(user.uid).set({
      'user': user.uid,
      'docUid': document.data()['doctor']['docUid'],
      'docName': document.data()['doctor']['docName'],
    });
    return add.doc(user.uid).collection('packages').add({
      'packageId': document.data()['packageId'],
      'packageName': document.data()['packageName'],
      'packageImage': document.data()['packageImage'],
      'mainCategory':document.data()['categoryName']['mainCategory'],
      'subCategory':document.data()['categoryName']['subCategory'],
      'price': document.data()['price'],
      'total': document.data()['price'],
    });
  }

  Future<void> removeFromAdd(docId) async {
    add.doc(user.uid).collection('packages').doc(docId).delete();
  }

  Future<void> checkData() async {
    final snapshot = await add.doc(user.uid).collection('packages').get();
    if (snapshot.docs.length == 0) {
      add.doc(user.uid).delete();
    }
  }

  Future<void> deleteData() async {
    final result =
        await add.doc(user.uid).collection('packages').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  Future<String> checkDoctor() async {
    final snapshot = await add.doc(user.uid).get();
    return snapshot.exists ? snapshot.data()['docName'] : null;
  }


}
