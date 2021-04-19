import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PackageCard extends StatelessWidget {
  final DocumentSnapshot document;
  PackageCard(this.document);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 160,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
          child: Row(
            children: [
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: 140,
                  width: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(document.data()['packageImage'],fit: BoxFit.fill,)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top:10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            document.data()['collection'],
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            document.data()['packageName'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 160,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.grey[200],
                            ),
                            child: Text(
                              document.data()['categoryName']['subCategory'],
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                'Price',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                              '\Rs.${document.data()['price'].toStringAsFixed(0)}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 160,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Card(
                                  color: Colors.pink[200],
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30, top: 7, bottom: 7),
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
