import 'package:famdoc_user/providers/location_provider.dart';

import 'package:famdoc_user/screens/map_screen.dart';

import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  static const String id = 'landing-screen';
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  LocationProvider _locationProvider = LocationProvider();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Address not set',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Please update your Location to find nearest Doctors for you.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Container(child: Image.asset('images/city.png')),
            _loading ? CircularProgressIndicator() : FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                setState(() {
                  _loading = true;
                });
                await _locationProvider.getCurrentPosition();
                if (_locationProvider.permissionAllowed == true) {
                  Navigator.pushReplacementNamed(context, MapScreen.id);
                } else {
                  Future.delayed(Duration(seconds: 4), () {
                    if (_locationProvider.permissionAllowed == false) {
                      print('Permission Not Allowed');
                      setState(() {
                        _loading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Please allow permission to find nearest Doctors for you')));
                    }
                  });
                }
              },
              child: Text(
                'Set Your Location',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
