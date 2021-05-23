import 'package:famdoc_user/medireminder/mediMain.dart';
import 'package:famdoc_user/providers/auth_provider.dart';
import 'package:famdoc_user/providers/location_provider.dart';
import 'package:famdoc_user/screens/home_screen.dart';
import 'package:famdoc_user/screens/map_screen.dart';
import 'package:famdoc_user/screens/my_buy_packages.dart';
import 'package:famdoc_user/screens/new_Edit_profile.dart';
import 'package:famdoc_user/screens/profile.dart';
import 'package:famdoc_user/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = true;
  @override
  Widget build(BuildContext context) {
    var userDetails = Provider.of<AuthProvider>(context);
    var locationData = Provider.of<LocationProvider>(context);
    User user = FirebaseAuth.instance.currentUser;
    userDetails.getUserDetails();
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 40, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 400),
                        transitionsBuilder:
                            (context, animation, animationTime, child) {
                          animation:
                          CurvedAnimation(
                              parent: animation, curve: Curves.elasticInOut);
                          return ScaleTransition(
                            alignment: Alignment.centerRight,
                            scale: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, animationTime) {
                          return NewEditProfileScreen();
                        },
                      ));
                },
                child: CircleAvatar(
                  radius: 32,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Text(
                      userDetails.snapshot.data()['firstName'] != null
                          ? '${userDetails.snapshot.data()['firstName']} ${userDetails.snapshot.data()['lastName']}'
                          : 'Update Your Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    onTap: () {
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
                                alignment: Alignment.centerRight,
                                scale: animation,
                                child: child,
                              );
                            },
                            pageBuilder: (context, animation, animationTime) {
                              return NewEditProfileScreen();
                            },
                          ));
                    },
                  ),
                  Text(
                    'Active',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
          Column(children: [
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'Home',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 400),
                      transitionsBuilder:
                          (context, animation, animationTime, child) {
                        animation:
                        CurvedAnimation(
                            parent: animation, curve: Curves.elasticInOut);
                        return ScaleTransition(
                          alignment: Alignment.centerRight,
                          scale: animation,
                          child: child,
                        );
                      },
                      pageBuilder: (context, animation, animationTime) {
                        return HomeScreen();
                      },
                    ));
              },
            ),
            ListTile(
                leading: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 400),
                        transitionsBuilder:
                            (context, animation, animationTime, child) {
                          animation:
                          CurvedAnimation(
                              parent: animation, curve: Curves.elasticInOut);
                          return ScaleTransition(
                            alignment: Alignment.centerRight,
                            scale: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, animationTime) {
                          return NewEditProfileScreen();
                        },
                      ));
                }),
            ListTile(
                leading: Icon(
                  Icons.healing,
                  color: Colors.white,
                  size: 27,
                ),
                title: Text(
                  'My Medicine',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 400),
                        transitionsBuilder:
                            (context, animation, animationTime, child) {
                          animation:
                          CurvedAnimation(
                              parent: animation, curve: Curves.elasticInOut);
                          return ScaleTransition(
                            alignment: Alignment.centerRight,
                            scale: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, animationTime) {
                          return MedicineReminder();
                        },
                      ));
                }),
            ListTile(
                leading: Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  'Favourite',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 400),
                        transitionsBuilder:
                            (context, animation, animationTime, child) {
                          animation:
                          CurvedAnimation(
                              parent: animation, curve: Curves.elasticInOut);
                          return ScaleTransition(
                            alignment: Alignment.centerRight,
                            scale: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, animationTime) {
                          return ProfilePage();
                        },
                      ));
                }),
            ListTile(
                leading: Icon(
                  Icons.my_library_add,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  'My Hire',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 400),
                        transitionsBuilder:
                            (context, animation, animationTime, child) {
                          animation:
                          CurvedAnimation(
                              parent: animation, curve: Curves.elasticInOut);
                          return ScaleTransition(
                            alignment: Alignment.centerRight,
                            scale: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, animationTime) {
                          return MyBuyPackages();
                        },
                      ));
                }),
            ListTile(
                leading: Icon(
                  Icons.location_city_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  'Set Location',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 400),
                        transitionsBuilder:
                            (context, animation, animationTime, child) {
                          animation:
                          CurvedAnimation(
                              parent: animation, curve: Curves.elasticInOut);
                          return ScaleTransition(
                            alignment: Alignment.centerRight,
                            scale: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, animationTime) {
                          return MapScreen();
                        },
                      ));
                }),
            ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  'Log Out',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ));
                  });
                }),
            SizedBox(
              height: 140,
            )
          ]),
        ],
      ),
    );
  }
}

// List<Map> drawerItem = [
//   {'icon': Icons.home, 'title': 'Home',},
//   {'icon': Icons.account_circle, 'title': 'Profile'},
//   {'icon': Icons.favorite, 'title': 'Favourite'},
//   {'icon': Icons.message, 'title': 'Messages'},
//   {'icon': Icons.collections_sharp, 'title': 'My Collection'},

// ];
