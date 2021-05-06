import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/providers/request_provider.dart';
import 'package:famdoc_user/services/hire_request_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyBuyPackages extends StatefulWidget {
  static const String id = 'my-buying';
  @override
  _MyBuyPackagesState createState() => _MyBuyPackagesState();
}

class _MyBuyPackagesState extends State<MyBuyPackages> {
  RequestServices _requestServices = RequestServices();
  User user = FirebaseAuth.instance.currentUser;

  int tag = 0;
  List<String> options = [
    'All Requests',
    'Requested',
    'Accepted',
    'Rejected',
    'On the way',
    'Completed',
  ];

  @override
  Widget build(BuildContext context) {
    var _requestProvider = Provider.of<RequestProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
      body: Column(
        children: [
          Container(
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: ChipsChoice<int>.single(
              choiceStyle: C2ChoiceStyle(
                borderRadius: BorderRadius.all(Radius.circular(17)),
              ),
              value: tag,
              onChanged: (val) {
                if (val == 0) {
                  _requestProvider.status = null;
                }
                setState(() {
                  tag = val;
                  if (tag > 0) {
                    _requestProvider.filterRequest(options[val]);
                  }
                });
              },
              choiceItems: C2Choice.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
            ),
          ),
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: _requestServices.requests
                  .where('userId', isEqualTo: user.uid)
                  .where('orderStatus', isEqualTo: _requestProvider.status)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.data.size == 0) {
                  return Center(
                    child: Text(tag > 0
                        ? 'No ${options[tag]} requests'
                        : 'No Request Packages.Continue Buying Packages'),
                  );
                }

                return Expanded(
                  child: new ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return new Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              horizontalTitleGap: 0,
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 15,
                                child: _requestServices.statusIcon(document),
                              ),
                              title: Text(
                                document.data()['orderStatus'],
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        _requestServices.statusColor(document),
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'On ${DateFormat.yMMMd().format(
                                  DateTime.parse(document.data()['timestamp']),
                                )}',
                                style: TextStyle(fontSize: 12),
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Payment Type : ${document.data()['cod'] == true ? 'Pay After Visit' : 'Paid Online'}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Price : \Rs.${document.data()['total'].toStringAsFixed(0)}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                            //TODO: Visiting Doctor contact,live location
                            if (document.data()['doctor']['docName'].length > 2)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.3),
                                  child: ListTile(
                                    tileColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.3),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Icon(CupertinoIcons.person_alt,
                                          size: 35,
                                          color: _requestServices
                                              .statusColor(document)),
                                    ),
                                    title: Text(
                                        'Dr. ${document.data()['doctor']['docName']},',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: _requestServices
                                                .statusColor(document))),
                                    subtitle: Text(
                                      _requestServices.statusComment(document),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: _requestServices
                                              .statusColor(document)),
                                    ),
                                  ),
                                ),
                              ),

                            ExpansionTile(
                              title: Text(
                                'Request Details',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                'View Request Details',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Image.network(
                                            document.data()['packages'][index]
                                                ['packageImage']),
                                      ),
                                      title: Text(document.data()['packages']
                                          [index]['packageName']),
                                      subtitle: Text(
                                          '${document.data()['packages'][index]['mainCategory']} ${document.data()['packages'][index]['subCategory']} '),
                                    );
                                  },
                                  itemCount: document.data()['packages'].length,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 8, bottom: 8),
                                  child: Card(
                                    elevation: 4,
                                    color: Colors.white.withOpacity(0.8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Doctor : Dr. ',
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                document.data()['doctor']
                                                    ['docName'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          if (int.parse(
                                                  document.data()['discount']) >
                                              0)
                                            Container(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Discount : Rs. ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black45,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        document
                                                            .data()['discount'],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Discount Code: ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black45,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        document.data()[
                                                            'discountCode'],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Visiting Fee: Rs. ',
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                document
                                                    .data()['visitingFee']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(height: 3, color: Colors.grey)
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
