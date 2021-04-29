import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/services/add_services.dart';
import 'package:flutter/cupertino.dart';

class AddProvider with ChangeNotifier {
  AddServices _add = AddServices();
  double subTotal = 0.0;
  int addQty = 0;
  QuerySnapshot snapshot;
  DocumentSnapshot document;
  double distance = 0.0;
  bool cod = false;
  List addList = [];

  Future<double> getAddTotal() async {
    var addTotal = 0.0;
    List _newList = [];
    QuerySnapshot snapshot =
        await _add.add.doc(_add.user.uid).collection('packages').get();
    if (snapshot == null) {
      return null;
    }
    snapshot.docs.forEach((doc) {
      if (!_newList.contains(doc.data())) {
        _newList.add(doc.data());
        this.addList = _newList;
        notifyListeners();
      }
      addTotal = addTotal + doc.data()['total'];
    });

    this.subTotal = addTotal;
    this.addQty = snapshot.size;
    this.snapshot = snapshot;
    notifyListeners();

    return addTotal;
  }

  getDistance(distance) {
    this.distance = distance;
    notifyListeners();
  }

  getPaymentMethod(index) {
    if (index == 0) {
      this.cod = false;
      notifyListeners();
    } else {
      this.cod = true;
      notifyListeners();
    }
  }

  getDoctorName() async {
    DocumentSnapshot doc = await _add.add.doc(_add.user.uid).get();
    if (doc.exists) {
      this.document = doc;
      notifyListeners();
    } else {
      this.document = null;
      notifyListeners();
    }
  }
}
