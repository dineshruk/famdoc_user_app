import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorService {

 CollectionReference doctorbanner =
      FirebaseFirestore.instance.collection('doctorcover');


  getTopNearDoctor() {
    return FirebaseFirestore.instance
        .collection('doctors')
        .where('verified', isEqualTo: true)
        .where('docAvaiable', isEqualTo: true)
        .orderBy('docName')
        .snapshots();
  }



    getAllDoctor() {
    return FirebaseFirestore.instance
        .collection('doctors')
        .where('verified', isEqualTo: true)
        .orderBy('docName')
        .snapshots();
  }

  geiAllDoctorPagination(){
    return FirebaseFirestore.instance
        .collection('doctors')
        .where('verified', isEqualTo: true)
        .orderBy('docName');
  }
}
