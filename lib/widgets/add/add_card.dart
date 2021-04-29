import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/widgets/add/counter.dart';
import 'package:flutter/material.dart';

class AddCard extends StatelessWidget {
  final DocumentSnapshot document;
  AddCard({this.document});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration:
          BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300])),
            color: Colors.white,
            ),
            //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      document.data()['packageImage'],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document.data()['packageName'],
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        document.data()['packageId'],
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Rs. ${document.data()['price'].toStringAsFixed(0)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              right: 0.0,bottom: 0.0,
              child: CounterForCard(document),
            )
          ],
        ),
      ),
    );
  }
}
