import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/providers/doctor_provider.dart';
import 'package:famdoc_user/services/package_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackageFilterWidget extends StatefulWidget {
  @override
  _PackageFilterWidgetState createState() => _PackageFilterWidgetState();
}

class _PackageFilterWidgetState extends State<PackageFilterWidget> {
  List _subCatList = [];
  PackageServices _services = PackageServices();

  @override
  void didChangeDependencies() {
    var _doctor = Provider.of<DoctorProvider>(context);

    FirebaseFirestore.instance
        .collection('packages')
        .where('categoryName.mainCategory',
            isEqualTo: _doctor.selectedPackageCategory)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _subCatList.add(doc['categoryName']['subCategory']);
        });
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var _doctorData = Provider.of<DoctorProvider>(context);
    return FutureBuilder<DocumentSnapshot>(
      future: _services.category.doc(_doctorData.selectedPackageCategory).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (!snapshot.hasData) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Container(
              height: 50,
              color: Colors.grey,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ActionChip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    label: Text(
                        'All ${_doctorData.selectedPackageCategory} Packages'),
                    onPressed: () {
                        _doctorData.selectedCategorySub(null );
                    },
                    backgroundColor: Colors.white,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child:
                              //_subCatList.contains(data['subCat'][index]['name'])?
                              ActionChip(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 4,
                            label: Text(
                              data['subCat'][index]['name'],
                            ),
                            onPressed: () {
                              _doctorData.selectedCategorySub(
                                data['subCat'][index]['name'],
                              );
                            },
                            backgroundColor: Colors.white,
                          ) //:Container(),
                          );
                    },
                    itemCount: data.length,
                  )
                ],
              ));
        }

        return Container();
      },
    );
  }
}
