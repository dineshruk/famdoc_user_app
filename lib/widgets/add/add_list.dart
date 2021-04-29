import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/services/add_services.dart';
import 'package:famdoc_user/widgets/add/add_card.dart';
import 'package:flutter/material.dart';

class AddList extends StatefulWidget {
  final DocumentSnapshot document;
  AddList({this.document});
  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  AddServices _add = AddServices();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _add.add.doc(_add.user.uid).collection('packages').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return new ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new AddCard(document:document,);
          }).toList(),
        );
      },
    );
  }
}
