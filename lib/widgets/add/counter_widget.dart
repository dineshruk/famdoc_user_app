import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/services/add_services.dart';
import 'package:famdoc_user/widgets/packages/add_to_buy_widget.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  final DocumentSnapshot document;
  final String docId;
  CounterWidget({this.document, this.docId});
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  AddServices _add = AddServices();
  bool _exists = true;
  @override
  Widget build(BuildContext context) {
    return _exists
        ? Container(
            decoration: BoxDecoration(color: Colors.red[400]),
            //margin: EdgeInsets.only(left: 20, right: 20),
            height: 56,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: FittedBox(
                  child: InkWell(
                    onTap: () {
                      _add.removeFromAdd(widget.docId).then((value) {
                        setState(() {
                          _exists = false;
                        });
                        _add.checkData();
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          // decoration: BoxDecoration(
                          //     border: Border.all(
                          //   color: Colors.white,
                          // ),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                        Text(
                          'Delete From List',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : AddToBuyWidget(widget.document);
  }
}
