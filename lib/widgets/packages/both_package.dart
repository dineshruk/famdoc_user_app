import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/providers/doctor_provider.dart';
import 'package:famdoc_user/services/package_services.dart';
import 'package:famdoc_user/widgets/packages/package_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BothPackage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PackageServices _services = PackageServices();
    var _doctor = Provider.of<DoctorProvider>(context);
    return FutureBuilder<QuerySnapshot>(
      future: _services.packages
          .where('published', isEqualTo: true)
          .where('collection', isEqualTo: 'Both Visit And Online Treatment')
          .where('doctor.docUid', isEqualTo: _doctor.doctordetails['uid'])
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
         if (!snapshot.hasData) {
          return Container();
        }
        if (snapshot.data.docs.isEmpty) {
          return Container();
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.teal[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Both Online And Visit Packages',
                      style: TextStyle(
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          )
                        ],
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            new ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return new PackageCard(document);
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
