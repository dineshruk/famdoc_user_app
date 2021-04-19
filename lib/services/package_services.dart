import 'package:cloud_firestore/cloud_firestore.dart';

class PackageServices {
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  CollectionReference packages =
      FirebaseFirestore.instance.collection('packages');
}
