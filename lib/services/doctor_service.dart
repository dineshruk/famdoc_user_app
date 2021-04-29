import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorService {
  CollectionReference doctorbanner =
      FirebaseFirestore.instance.collection('doctorcover');
  CollectionReference doctors =
      FirebaseFirestore.instance.collection('doctors');

  getTopNearDoctor() {
    return doctors
        .where('verified', isEqualTo: true)
        .where('docAvaiable', isEqualTo: true)
        .orderBy('docName')
        .snapshots();
  }

  getAllDoctor() {
    return doctors
        .where('verified', isEqualTo: true)
        .orderBy('docName')
        .snapshots();
  }

  geiAllDoctorPagination() {
    return doctors.where('verified', isEqualTo: true).orderBy('docName');
  }

  Future<DocumentSnapshot> getDoctorDetails(docUid) async {
    DocumentSnapshot snapshot = await doctors.doc(docUid).get();
    return snapshot;
  }
}
