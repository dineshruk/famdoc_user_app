import 'package:famdoc_user/providers/auth_provider.dart';
import 'package:famdoc_user/providers/location_provider.dart';
import 'package:famdoc_user/screens/map_screen.dart';
import 'package:famdoc_user/screens/profile_update_screen.dart';
import 'package:famdoc_user/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class NewEditProfileScreen extends StatelessWidget {
  static const String id = 'new-profile-edit';
  @override
  Widget build(BuildContext context) {
    var userDetails = Provider.of<AuthProvider>(context);
    var locationData = Provider.of<LocationProvider>(context);
    User user = FirebaseAuth.instance.currentUser;
    userDetails.getUserDetails();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Edit Your Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('MY ACCOUNT',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Stack(
                children: [
                  Container(
                    color: Colors.blueGrey[400],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  'D',
                                  style: TextStyle(fontSize: 50),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Container(
                                height: 70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      userDetails.snapshot.data()['firstName'] != null
                                          ? '${userDetails.snapshot.data()['firstName']} ${userDetails.snapshot.data()['lastName']}'
                                          : 'Update Your Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                    if (userDetails.snapshot.data()['email'] != null)
                                      Text(
                                        '${userDetails.snapshot.data()['email']}',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    Text(user.phoneNumber,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          if (userDetails.snapshot != null)
                            ListTile(
                              tileColor: Colors.white,
                              leading: Icon(
                                Icons.location_on,
                                color: Colors.redAccent,
                              ),
                              title:
                                  Text(userDetails.snapshot.data()['location']),
                              subtitle: Text(
                                userDetails.snapshot.data()['address'],
                                maxLines: 1,
                              ),
                              trailing: SizedBox(
                                width: 80,
                                child: OutlineButton(
                                  borderSide:
                                      BorderSide(color: Colors.red[700]),
                                  child: Text(
                                    'Change',
                                    style: TextStyle(color: Colors.red[700]),
                                  ),
                                  onPressed: () {
                                    EasyLoading.show(status: 'Please Wait...');
                                    locationData
                                        .getCurrentPosition()
                                        .then((value) {
                                      if (value != null) {
                                        EasyLoading.dismiss();
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              transitionDuration:
                                                  Duration(milliseconds: 400),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  animationTime,
                                                  child) {
                                                animation:
                                                CurvedAnimation(
                                                    parent: animation,
                                                    curve: Curves.elasticInOut);
                                                return ScaleTransition(
                                                  alignment: Alignment.topRight,
                                                  scale: animation,
                                                  child: child,
                                                );
                                              },
                                              pageBuilder: (context, animation,
                                                  animationTime) {
                                                return MapScreen();
                                              },
                                            ));
                                      } else {
                                        EasyLoading.dismiss();
                                        print('Permission not allowed');
                                      }
                                    });
                                  },
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 400),
                              transitionsBuilder:
                                  (context, animation, animationTime, child) {
                                animation:
                                CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.elasticInOut);
                                return ScaleTransition(
                                  alignment: Alignment.topRight,
                                  scale: animation,
                                  child: child,
                                );
                              },
                              pageBuilder: (context, animation, animationTime) {
                                return UpdateProfile();
                              },
                            ));
                      },
                    ),
                  ),
                ],
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('My Hirings'),
                horizontalTitleGap: 2,
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.comment_outlined),
                title: Text('My Ratings & Reviews'),
                horizontalTitleGap: 2,
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.notifications_none),
                title: Text('Notifications'),
                horizontalTitleGap: 2,
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                horizontalTitleGap: 2,
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, WelcomeScreen.id);
                },
              ),
            ],
          )),
    );
  }
}
