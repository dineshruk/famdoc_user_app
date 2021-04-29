import 'package:famdoc_user/providers/auth_provider.dart';
import 'package:famdoc_user/providers/location_provider.dart';
import 'package:famdoc_user/screens/home_screen.dart';
import 'package:famdoc_user/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  static const String id = 'map-screen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng currentLocation = LatLng(37.421632, 122.084664);
  GoogleMapController _mapController;
  bool _locating = false;
  bool loggedIn = false;
  User user;

  @override
  void initState() {
    //check user logged in or not , while opening map screen
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() {
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });
    if (user != null) {
      setState(() {
        loggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);
    final _auth = Provider.of<AuthProvider>(context);

    setState(() {
      currentLocation = LatLng(locationData.latitude, locationData.longitude);
    });

    void onCreated(GoogleMapController controller) {
      setState(() {
        _mapController = controller;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: currentLocation,
                  zoom: 14.4746,
                ),
                zoomControlsEnabled: false,
                minMaxZoomPreference: MinMaxZoomPreference(1.5, 20.8),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                mapToolbarEnabled: true,
                onCameraMove: (CameraPosition position) {
                  setState(() {
                    _locating = true;
                  });
                  locationData.onCameraMove(position);
                },
                onMapCreated: onCreated,
                onCameraIdle: () {
                  setState(() {
                    _locating = false;
                  });
                  locationData.getMoveCamera();
                }),
            Center(
              child: Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 45),
                child: Image.asset(
                  'images/marker.png',
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _locating
                          ? LinearProgressIndicator(
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        child: TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_searching,
                              color: Theme.of(context).primaryColor,
                            ),
                            label: Flexible(
                              child: Text(
                                _locating
                                    ? 'Locating...'
                                    : locationData.selectedAddress == null
                                        ? 'Locating...'
                                        : locationData
                                            .selectedAddress.featureName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 5),
                        child: Text(_locating
                            ? ''
                            : locationData.selectedAddress == null
                                ? ''
                                : locationData.selectedAddress.addressLine),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: AbsorbPointer(
                            absorbing: _locating ? true : false,
                            child: FlatButton(
                              color: _locating
                                  ? Colors.grey
                                  : Theme.of(context).primaryColor,
                              onPressed: () {
                                locationData.savePrefs();
                                if (loggedIn == false) {
                                  Navigator.pushReplacementNamed(
                                      context, LoginScreen.id);
                                } else {
                                  setState(() {
                                    _auth.latitude = locationData.latitude;
                                    _auth.longitude = locationData.longitude;
                                    _auth.address = locationData
                                        .selectedAddress.addressLine;
                                    _auth.location = locationData
                                        .selectedAddress.featureName;
                                  });
                                  _auth.updateUser(
                                    id: user.uid,
                                    number: user.phoneNumber,
                                    
                                  );
                                  //     .then((value) {
                                  //   if (value == true) {
                                  //     Navigator.pushReplacementNamed(
                                  //         context, HomeScreen.id);
                                  //   }
                                  // });
                                  Navigator.pushReplacementNamed(
                                      context, HomeScreen.id);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text('CONFIRM LOCATION',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
