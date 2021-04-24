import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/providers/doctor_provider.dart';
import 'package:famdoc_user/screens/package_list_screen.dart';
import 'package:famdoc_user/widgets/packages/package_list_widget.dart';
import 'package:famdoc_user/services/package_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorCategory extends StatefulWidget {
  @override
  _DoctorCategoryState createState() => _DoctorCategoryState();
}

class _DoctorCategoryState extends State<DoctorCategory> {
  PackageServices _services = PackageServices();
  List _catList = [];
  @override
  void didChangeDependencies() {
    var _doctor = Provider.of<DoctorProvider>(context);
    
    FirebaseFirestore.instance
        .collection('packages')
        .where('doctor.docUid', isEqualTo: _doctor.doctordetails['uid'])
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  _catList.add(doc['categoryName']['mainCategory']);
                });
              }),
            });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var _doctorProvider = Provider.of<DoctorProvider>(context);
    
    return FutureBuilder(
        future: _services.category.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went Wrong'),
            );
          }
          if (_catList.length == 0) {
            return Center(
              child: Text(
                'Still Doctor Not Add Packages',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Container();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 7,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/packcover1.jpg'),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Packages By Category',
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
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return _catList.contains(document.data()['name'])
                        ? InkWell(
                            onTap: () {
                              _doctorProvider
                                  .selectedCategory(document.data()['name']);
                              _doctorProvider.selectedCategorySub(null);
                              Navigator.pushNamed(
                                  context, PackageListScreen.id);
                            },
                            child: Container(
                              width: 80,
                              height: 110,
                              child: Card(
                                child: Column(
                                  children: [
                                    Center(
                                      child: Image.network(
                                          document.data()['image']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                        top: 8,
                                      ),
                                      child: Text(
                                        document.data()['name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Text('');
                  }).toList(),
                ),
              ],
            ),
          );
        });
  }
}
