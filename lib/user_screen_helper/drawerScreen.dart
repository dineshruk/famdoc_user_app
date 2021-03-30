import 'package:famdoc_user/screens/home_screen.dart';
import 'package:famdoc_user/screens/profile.dart';
import 'package:famdoc_user/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
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
                          return ProfilePage();
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
                      'Dinesh Rukshan',
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
                              return ProfilePage();
                            },
                          ));
                    },
                  ),
                  Text(
                    'Active Status',
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
                          return ProfilePage();
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
                          return ProfilePage();
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
                  Icons.how_to_reg_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  'Connected Doctors',
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
                  Icons.how_to_reg_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  'Connected Doctors',
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
                  Icons.apps_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                title: Text(
                  'About App',
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
          ]),
          Row(
            children: [
              SizedBox(
                height: 2,
                width: 50,
              ),
              GestureDetector(
                child: Icon(Icons.location_city_outlined, color: Colors.white),
                onTap: () {
                  Navigator.pushReplacementNamed(context, WelcomeScreen.id);
                },
              ),
              SizedBox(
                width: 1,
              ),
              FlatButton(
                child: Text(
                  'Set Location',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, WelcomeScreen.id);
                },
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 3,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              
            ],
          ),
          Row(children: [
            SizedBox(
                height: 2,
                width: 50,
              ),
            FlatButton(
                child: Text('Log Out',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ));
                  });
                },
              ),
              GestureDetector(
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ));
                  });
                },
              ),
          ],)
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
