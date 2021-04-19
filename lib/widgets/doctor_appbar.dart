import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/providers/doctor_provider.dart';
import 'package:famdoc_user/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _doctor = Provider.of<DoctorProvider>(context);

    mapLauncher() async {
      GeoPoint location = _doctor.doctordetails['location'];
      final availableMaps = await MapLauncher.installedMaps;

      await availableMaps.first.showMarker(
        coords: Coords(location.latitude, location.longitude),
        title: 'Dr ${_doctor.doctordetails['docName']} is here.',
      );
    }

    return SliverAppBar(
      floating: true,
      snap: true,
      leading: BackButton(
        color: Colors.white,
        onPressed: () => Navigator.pushReplacementNamed(context, HomeScreen.id),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      expandedHeight: 280,
      flexibleSpace: SizedBox(
          child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Card(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_doctor.doctordetails['imageURL']),
                ),
              ),
              child: Container(
                color: Colors.grey.withOpacity(.7),
                child: ListView(
                  padding: EdgeInsets.only(left: 7),
                  children: [
                    Text(
                      'Dr .${_doctor.doctordetails['docName']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _doctor.doctordetails['speciality'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _doctor.doctordetails['hospital'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      _doctor.doctordetails['address'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      _doctor.doctordetails['email'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${_doctor.distance}km',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.white),
                        Icon(Icons.star, color: Colors.white),
                        Icon(Icons.star, color: Colors.white),
                        Icon(Icons.star_half, color: Colors.white),
                        Icon(Icons.star_outline, color: Colors.white),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '(3.5)',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 61,
                            height: 61,
                            child: Card(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                _doctor.doctordetails['imageURL'],
                                fit: BoxFit.cover,
                              ),
                            )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite_outline_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            width: 70,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.phone,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    launch(
                                        'tel:${_doctor.doctordetails['mobile']}');
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.message_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.map_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    mapLauncher();
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
      actions: [
        IconButton(icon: Icon(CupertinoIcons.search), onPressed: () {}),
      ],
      title: Center(
        child: Text(
          'Dr .${_doctor.doctordetails['docName']}',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
