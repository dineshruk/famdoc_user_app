
import 'package:famdoc_user/providers/addProvider.dart';
import 'package:famdoc_user/screens/add_list_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNotification extends StatefulWidget {
  @override
  _AddNotificationState createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  @override
  Widget build(BuildContext context) {
    final _addProvider = Provider.of<AddProvider>(context);
    _addProvider.getAddTotal();
    _addProvider.getDoctorName();

    return Visibility(
      visible: _addProvider.distance <= 10
          ? _addProvider.addQty > 0
              ? true
              : false
          : false,
      child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${_addProvider.addQty}  ${_addProvider.addQty == 1 ? 'Package' : 'Packages'}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '  |  ',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                '\Rs.${_addProvider.subTotal.toStringAsFixed(0)}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if (_addProvider.document!=null)
                            Text(
                              'From Dr. ${_addProvider.document.data()['docName']}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 400),
                              transitionsBuilder:
                                  (context, animation, animationTime, child) {
                                animation:
                                CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.elasticInOut);
                                return ScaleTransition(
                                  alignment: Alignment.bottomRight,
                                  scale: animation,
                                  child: child,
                                );
                              },
                              pageBuilder: (context, animation, animationTime) {
                                return AddScreen(
                                  document: _addProvider.document,
                                );
                              },
                            ));
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              'View Add List',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Icon(Icons.post_add, color: Colors.white),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
