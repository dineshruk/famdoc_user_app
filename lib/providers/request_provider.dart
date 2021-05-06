import 'package:flutter/cupertino.dart';

class RequestProvider with ChangeNotifier {
  String status;
  String amount;
  bool success = false;
  String docName;
  String email;

  filterRequest(status) {
    this.status = status;
    notifyListeners();
  }

  totalAmount(amount, docName, email) {
    this.amount = amount.toStringAsFixed(0);
    this.docName = docName;
    this.email = email;
    notifyListeners();
  }

  paymentStatus(success) {
    this.success = success;
    notifyListeners();
  }
}
