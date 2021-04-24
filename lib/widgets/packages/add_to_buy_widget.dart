import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/services/add_services.dart';
import 'package:famdoc_user/widgets/add/counter_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddToBuyWidget extends StatefulWidget {
  final DocumentSnapshot document;
  AddToBuyWidget(this.document);
  @override
  _AddToBuyWidgetState createState() => _AddToBuyWidgetState();
}

class _AddToBuyWidgetState extends State<AddToBuyWidget> {
  AddServices _add = AddServices();
  User user = FirebaseAuth.instance.currentUser;
  bool _loading = true;
  bool _exist = false;
  String _docId;
  @override
  void initState() {
    getAddToBuyData();
    super.initState();
  }

  getAddToBuyData() async {
    final snapshot = await _add.add.doc(user.uid).collection('packages').get();
    if (snapshot.docs.length == 0) {
      setState(() {
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('add')
        .doc(user.uid)
        .collection('packages')
        .where('packageId', isEqualTo: widget.document.data()['packageId'])
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['packageId'] == widget.document.data()['packageId']) {
          setState(() {
            _exist = true;
            _docId = doc.id;
          });
        }
      });
    });

    return _loading
        ? Container(
            height: 56,
            child: Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            )),
          )
        : _exist
            ? CounterWidget(
                document: widget.document,
                docId: _docId,
              )
            : InkWell(
                onTap: () {
                  EasyLoading.show(status: 'Adding to buy Screen');
                  _add.addToBuy(widget.document).then((value) {
                    setState(() {
                      _exist=true;
                    });
                    
                    EasyLoading.showSuccess('Added to buy Screen');
                    
                  });
                },
                child: Container(
                  height: 56,
                  color: Colors.red[400],
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shopping_basket_outlined,
                            color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Buy',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
                ),
              );
  }
}
