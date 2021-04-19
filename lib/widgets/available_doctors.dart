import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/constants.dart';
import 'package:famdoc_user/providers/doctor_provider.dart';
import 'package:famdoc_user/services/doctor_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

class AvailableDoctors extends StatefulWidget {
  @override
  _AvailableDoctorsState createState() => _AvailableDoctorsState();
}

class _AvailableDoctorsState extends State<AvailableDoctors> {

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

    DoctorService _doctorService = DoctorService();
    PaginateRefreshedChangeListener refreshedChangeListener =
        PaginateRefreshedChangeListener();


  @override
  Widget build(BuildContext context) {
    
    final _doctorData = Provider.of<DoctorProvider>(context);
    _doctorData.getUserLocationData(context);
    

    return Container(
        child: StreamBuilder<QuerySnapshot>(
      stream: _doctorService.getTopNearDoctor(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
        if (!snapShot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
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
                Image.asset(
                  'images/notavailable.png',
                ),
                // Positioned(top: 80,
                // child: Container(width: 100,
                // child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                // children: [Text('Made By Final Year Project NSBM')],
                // ),),)
              ],
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RefreshIndicator(
                child: PaginateFirestore(
                  bottomLoader: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                  header: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 20),
                        child: Text(
                          'All Available Doctors In This Time',
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                        child: Text(
                          'Find Out Preffered Doctors For You',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilderType: PaginateBuilderType.listView,
                  itemBuilder: (index, context, document) => Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 110,
                            child: Card(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                document['imageURL'],
                                fit: BoxFit.cover,
                              ),
                            )),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  document['docName'],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                document['speciality'],
                                style: KDoctorCardStyle,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 250,
                                child: Text(
                                  document['hospital'],
                                  overflow: TextOverflow.ellipsis,
                                  style: KDoctorCardStyle,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${getDistance(document['location'])}Km',
                                overflow: TextOverflow.ellipsis,
                                style: KDoctorCardStyle,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rate,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '3.2',
                                    style: KDoctorCardStyle,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  query: _doctorService.geiAllDoctorPagination(),
                  listeners: [
                    refreshedChangeListener,
                  ],
                  footer: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              '**Thats All Available Doctors In Your Area**',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Image.asset(
                            'images/city.png',
                            color: Colors.black12,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                onRefresh: () async {
                  refreshedChangeListener.refreshed = true;
                },
              )
            ],
          ),
        );
      },
    ));
  }
}
