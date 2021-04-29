import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/services/hire_request_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyBuyPackages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RequestServices _requestServices = RequestServices();
    User user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Hire Request'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _requestServices.requests
              .where('userId', isEqualTo: user.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text('No Request Packages.Continue Buying Packages'),
              );
            }

            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return new Container(
                  child: Column(
                    children: [
                      ListTile(
                        horizontalTitleGap: 0,
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: Icon(
                            CupertinoIcons.square_list,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          document.data()['orderStatus'],
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'On ${DateFormat.yMMMd().format(
                            DateTime.parse(document.data()['timestamp']),
                          )}',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Text(
                          'Price : \Rs.${document.data()['total'].toStringAsFixed(0)}',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ExpansionTile(title: Text('Request Details'))
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
