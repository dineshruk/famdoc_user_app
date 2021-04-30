import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:famdoc_user/widgets/packages/bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PackageDetailsScreen extends StatelessWidget {
  static const String id = 'product-detail-screen';
  final DocumentSnapshot document;
  PackageDetailsScreen({this.document});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: Icon(CupertinoIcons.search), onPressed: () {})
        ],
      ),
      bottomSheet: BottomSheetContainer(document),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(.3),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 3,
                      top: 3,
                    ),
                    child: Text('${document.data()['collection']}'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              document.data()['packageName'],
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800]),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Time :'),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${document.data()['categoryName']['subCategory']} Onwards',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey[600],
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Package Price :'),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Rs. ${document.data()['price'].toStringAsFixed(0)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Hero(
                    tag: 'package${document.data()['packageImage']}',
                    child: Image.network(document.data()['packageImage']))),
            ),
            Divider(
              color: Colors.grey[400],
              thickness: 6,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  'About This Package ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 10,
                right: 10,
              ),
              child: ExpandableText(
                document.data()['description'],
                expandText: 'View more',
                collapseText: 'View less',
                maxLines: 2,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Divider(
              color: Colors.grey[400],
              thickness: 6,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  'Other Package Info ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 10,
                right: 10,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Doctor Name : Dr. ${document.data()['doctor']['docName']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'Package Category :  ${document.data()['categoryName']['mainCategory']}',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Future<void> saveForLater() {
    CollectionReference _favourite =
        FirebaseFirestore.instance.collection('favourite');
    User user = FirebaseAuth.instance.currentUser;
    //print(document.data());

    return _favourite.add({
      'package': document.data(),
      'customerId': user.uid,
    });
  }
}
