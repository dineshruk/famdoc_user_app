import 'package:famdoc_user/screens/profile.dart';
import 'package:famdoc_user/user_screen_helper/searchBar.dart';
import 'package:famdoc_user/widgets/image_slider.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  TextEditingController textController = TextEditingController();

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor)
            ..rotateY(isDrawerOpen ? -0.5 : 0),
          duration: Duration(milliseconds: 250),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0, 0.0),
              end: Alignment(1.0, 0.0),
              colors: [const Color(0xffbce6eb), const Color(0xFF26A69A)],
            ),
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDrawerOpen
                          ? IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 40,
                              ),
                              onPressed: () {
                                setState(() {
                                  xOffset = 0;
                                  yOffset = 0;
                                  scaleFactor = 1;
                                  isDrawerOpen = false;
                                });
                              })
                          : IconButton(
                              icon: Icon(
                                Icons.menu,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  xOffset = 230;
                                  yOffset = 150;
                                  scaleFactor = 0.6;
                                  isDrawerOpen = true;
                                });
                              }),
                      AnimationSearchBar(
                        width: 280,
                        autoFocus: true,
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.0, 0.0),
                        end: Alignment(1.0, 0.0),
                        colors: [
                          const Color(0xffbce6eb),
                          const Color(0xFF26A69A)
                        ], // whitish to gray
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        ImageSlider(),
                        // loadUserInfo(),

                        Container(
                          height: 700,
                          margin: const EdgeInsets.only(
                            top: 38.0,
                            right: 5,
                            left: 5,
                          ),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            ),
                            color: Color(0xFFFFFFFF),
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20.0,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 95,
                                width: 800,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  transform: Matrix4.translationValues(
                                      0.0, -30.0, 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () => setState(() {
                                              // initiatePhoneCall('tel:$_phone');
                                            }),
                                            color: Color(0xFF26A69A),
                                            highlightColor: Color(0xFF89b9f0),
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.batch_prediction_rounded,
                                              size: 30,
                                            ),
                                            padding: EdgeInsets.all(18),
                                            shape: CircleBorder(),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              top: 10.0,
                                            ),
                                            child: Text(
                                              ' Predict',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xFF6f6f6f),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfilePage()),
                                              );
                                            },
                                            color: Color(0xFF26A69A),
                                            highlightColor: Color(0xFF89b9f0),
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.people,
                                              size: 30,
                                            ),
                                            padding: EdgeInsets.all(18),
                                            shape: CircleBorder(),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              top: 10.0,
                                            ),
                                            child: Text(
                                              'Doctor',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xFF6f6f6f),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfilePage()));
                                            },
                                            color: Color(0xFF26A69A),
                                            highlightColor: Color(0xFF89b9f0),
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.family_restroom,
                                              size: 30,
                                            ),
                                            padding: EdgeInsets.all(18),
                                            shape: CircleBorder(),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              top: 10.0,
                                            ),
                                            child: Text(
                                              'FamDoc',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xFF6f6f6f),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () {},
                                            color: Color(0xFF26A69A),
                                            highlightColor: Color(0xFF89b9f0),
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.favorite_border,
                                              size: 30,
                                            ),
                                            padding: EdgeInsets.all(18),
                                            shape: CircleBorder(),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              top: 10.0,
                                            ),
                                            child: Text(
                                              'My Medi',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xFF6f6f6f),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //     height: 710,
                //     margin: const EdgeInsets.only(
                //       top: 8.0,
                //       right: 5,
                //       left: 5,
                //     ),
                //     decoration: new BoxDecoration(
                //         borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(25),
                //           topRight: Radius.circular(25),
                //           bottomRight: Radius.circular(25),
                //           bottomLeft: Radius.circular(25),
                //         ),
                //         color: Colors.transparent)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
