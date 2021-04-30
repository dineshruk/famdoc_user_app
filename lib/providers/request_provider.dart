import 'package:flutter/cupertino.dart';

class RequestProvider with ChangeNotifier {
  String status;

  filterRequest(status) {
    this.status = status;
    notifyListeners();
  }
}
