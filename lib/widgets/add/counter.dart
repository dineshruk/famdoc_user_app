import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/services/add_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CounterForCard extends StatefulWidget {
  final DocumentSnapshot document;
  CounterForCard(this.document);

  @override
  _CounterForCardState createState() => _CounterForCardState();
}

class _CounterForCardState extends State<CounterForCard> {
  User user = FirebaseAuth.instance.currentUser;
  AddServices _add = AddServices();
  String _docId;
  bool _exists = false;

  getAddData() {
    FirebaseFirestore.instance
        .collection('add')
        .doc(user.uid)
        .collection('packages')
        .where('packageId', isEqualTo: widget.document.data()['packageId'])
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          if (doc['packageId'] == widget.document.data()['packageId']) {
            setState(() {
              _docId = doc.id;
              _exists = true;
            });
          }
        });
      } else {
        setState(() {
          _exists = false;
        });
      }
    });
  }

  @override
  void initState() {
    getAddData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _exists
        ? StreamBuilder(
            stream: getAddData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Container(
                height: 28,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        EasyLoading.show(status: 'Removing From list..');
                        _add.removeFromAdd(_docId).then((value) {
                          setState(() {
                            _exists = false;
                          });
                          _add.checkData();
                          EasyLoading.showSuccess('Removed From List');
                        });
                      },
                      child: Container(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Icon(
                          Icons.delete_outline_outlined,
                          color: Colors.white,
                        ),
                      )),
                    )
                  ],
                ),
              );
            })
        : StreamBuilder(
            stream: getAddData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return InkWell(
                onTap: () {
                  EasyLoading.show(status: 'Adding to list..');
                  _add.checkDoctor().then((docName) {
                    //print(widget.document.data()['doctor']['docName']);
                    if (docName ==
                        widget.document.data()['doctor']['docName']) {
                      setState(() {
                        _exists = true;
                      });
                      _add.addToBuy(widget.document).then((value) {
                        EasyLoading.showSuccess('Added To List');
                      });
                      return;
                    }

                    if (docName == null) {
                      setState(() {
                        _exists = true;
                      });
                      _add.addToBuy(widget.document).then((value) {
                        EasyLoading.showSuccess('Added To List');
                      });
                      return;
                    }

                    if (docName !=
                        widget.document.data()['doctor']['docName']) {
                      EasyLoading.dismiss();
                      showDialog(docName);
                    }
                  });
                },
                child: Container(
                  height: 28,
                  //width: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        'ADD',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              );
            });
  }

  showDialog(docName) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Replace Package List?'),
          content: Text(
              'Your package list contains packages from Dr. $docName. Do you want to discard the selection and add packages from Dr. ${widget.document.data()['doctor']['docName']}'),
          actions: [
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                _add.deleteData().then((value) {
                  _add.add.doc(user.uid).delete().then((value) {
                  _add.addToBuy(widget.document);
                  setState(() {
                    _exists = true;
                  });
                  Navigator.pop(context);
                });
                });
                
              },
            ),
          ],
        );
      },
    );
  }
}
