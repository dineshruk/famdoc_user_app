import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/providers/doctor_provider.dart';
import 'package:famdoc_user/screens/doctor_home_screen.dart';
import 'package:famdoc_user/services/doctor_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class NearDoctors extends StatefulWidget {
  @override
  _NearDoctorsState createState() => _NearDoctorsState();
}

class _NearDoctorsState extends State<NearDoctors> {
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void didChangeDependencies() {
    final _doctorData = Provider.of<DoctorProvider>(context);
    _doctorData.determinePosition().then((position) {
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
    });
    super.didChangeDependencies();
  }

   String getDistance(location) {
      var distance = Geolocator.distanceBetween(latitude,
          longitude, location.latitude, location.longitude);
      var distanceInKm = distance / 1000;
      return distanceInKm.toStringAsFixed(2);
    }

  @override
  Widget build(BuildContext context) {
    DoctorService _doctorService = DoctorService();
    final _doctorData = Provider.of<DoctorProvider>(context);
   // _doctorData.getUserLocationData(context);
   

    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _doctorService.getTopNearDoctor(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
          if (!snapShot.hasData) return Center(child: CircularProgressIndicator());
          List docDistance = [];
          for (int i = 0; i <= snapShot.data.docs.length - 1; i++) {
            var distance = Geolocator.distanceBetween(
                latitude,
                longitude,
                snapShot.data.docs[i]['location'].latitude,
                snapShot.data.docs[i]['location'].longitude);
            var distanceInKm = distance / 1000;
            docDistance.add(distanceInKm);
          }
          docDistance.sort();
          if (docDistance[0] > 10) {
            return Container(
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      '**Currently There Has No Available Doctors In Your Area**',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  //Image.asset('images/notavailable.png',alignment: Alignment.center,),
                  Positioned(
                    top: 180,
                    child: Center(
                      child: Container(
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //children: [Center(child: Container(child: Text('Made By Final Year Project NSBM')))],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 20),
                  child: Row(
                    children: [
                      SizedBox(
                          height: 30, child: Image.asset('images/like.gif')),
                      Text(
                        'Top Rated Doctors',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                        snapShot.data.docs.map((DocumentSnapshot document) {
                      if (double.parse(getDistance(document['location'])) <=
                          10) {
                        return InkWell(
                          onTap: () {
                            _doctorData.geiselectedDoctor(document,getDistance(document['location']));
                            Navigator.pushReplacementNamed(
                                context, DoctorHomeScreen.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Card(
                                        child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.network(
                                        document['imageURL'],
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                  ),
                                  Container(
                                      height: 35,
                                      child: Text(
                                        '\Dr.${document['docName']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  Text('${getDistance(document['location'])}Km',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10)),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
