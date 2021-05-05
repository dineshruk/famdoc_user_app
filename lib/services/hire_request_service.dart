import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestServices {
  CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');

  Future<DocumentReference> saveRequest(Map<String, dynamic> data) {
    var result = requests.add(data);
    return result;
  }

  Color statusColor(document) {
    if (document.data()['orderStatus'] == 'Rejected') {
      return Colors.red;
    }
    if (document.data()['orderStatus'] == 'Accepted') {
      return Colors.blueGrey[400];
    }
    if (document.data()['orderStatus'] == 'On the way') {
      return Colors.pink[900];
    }
    if (document.data()['orderStatus'] == 'Completed') {
      return Colors.deepPurpleAccent;
    }
    return Colors.orange[900];
  }

  Icon statusIcon(DocumentSnapshot document) {
    if (document.data()['orderStatus'] == 'Accepted') {
      return Icon(
        Icons.assignment_turned_in_outlined,
        color: statusColor(document),
      );
    }
    if (document.data()['orderStatus'] == 'Rejected') {
      return Icon(
        Icons.cancel_schedule_send_outlined,
        color: statusColor(document),
      );
    }
    if (document.data()['orderStatus'] == 'On the way') {
      return Icon(
        CupertinoIcons.car_detailed,
        color: statusColor(document),
      );
    }
    if (document.data()['orderStatus'] == 'Completed') {
      return Icon(
        Icons.done_all_outlined,
        color: statusColor(document),
      );
    }
    return Icon(
      Icons.assignment_turned_in_outlined,
      color: statusColor(document),
    );
  }

  String statusComment(document) {
     if (document.data()['orderStatus'] == 'Requested') {
      return 'Please wait Dr.${document.data()['doctor']['docName']} response your request soon.';
    }
    if (document.data()['orderStatus'] == 'Accepted') {
      return 'Your request has Accepted by Dr.${document.data()['doctor']['docName']}';
    }
    if (document.data()['orderStatus'] == 'Rejected') {
      return 'Your request has Rejected by Dr. ${document.data()['doctor']['docName']}';
    }
     if (document.data()['orderStatus'] == 'On the way') {
      return '${document.data()['packages'][0]['mainCategory']} ${document.data()['packages'][0]['subCategory']} ready to treatment. Dr. ${document.data()['doctor']['docName']} is on the way';
    }
     return 'Your Treatment has completed by Dr. ${document.data()['doctor']['docName']}';
  }
}
