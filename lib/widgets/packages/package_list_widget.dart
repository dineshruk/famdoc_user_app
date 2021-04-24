import 'package:famdoc_user/providers/doctor_provider.dart';
import 'package:famdoc_user/widgets/packages/package_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/services/package_services.dart';
import 'package:famdoc_user/widgets/packages/package_card_widget.dart';
import 'package:provider/provider.dart';

class PackageListWidget extends StatelessWidget {
  static const String id = 'package-list-widget';
  @override
  Widget build(BuildContext context) {
    PackageServices _services = PackageServices();
    var _doctor = Provider.of<DoctorProvider>(context);

    return FutureBuilder<QuerySnapshot>(
      future: _services.packages
          .where('published', isEqualTo: true)
          .where('categoryName.mainCategory',
              isEqualTo: _doctor.selectedPackageCategory)
          .where('categoryName.subCategory',
              isEqualTo: _doctor.selectedPackageSubCategory)
          .where('doctor.docUid', isEqualTo: _doctor.doctordetails['uid'])
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data.docs.isEmpty) {
          return Container();
        }

        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 14),
                child: Text(
                  '${snapshot.data.docs.length} Packages',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[600]),
                ),
              ),
            ),
            new ListView(
              padding: EdgeInsets.zero,
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
