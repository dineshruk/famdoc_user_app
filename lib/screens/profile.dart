import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile-screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0, 0.0),
                end: Alignment(1.0, 0.0),
                colors: [
                  const Color(0xffbce6eb),
                  const Color(0xFF26A69A),
                ], // whitish to gray
              ),
            ),
            alignment: Alignment.center, // where to position the child
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
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
                      Container(
                        //transform: Matrix4.translationValues(0.0, -16.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 15.0,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  transform: Matrix4.translationValues(
                                      0.0, -15.0, 0.0),
                                  child: CircleAvatar(
                                    radius: 70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 15.0,
                          left: 40.0,
                          right: 40.0,
                          bottom: 30.0,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Hey " +
                                        //titleCase(name) +
                                        ", you're looking healthy today" ??
                                    "name not found",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  color: Color(0xFF6f6f6f),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 20.0,
                          right: 5.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 15.0,
                                    bottom: 15.0,
                                  ),
                                  decoration: new BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Color(0xFF26A69A),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        child: Text(
                                          "",
                                          //age ?? "",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Age",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 15.0,
                                    bottom: 15.0,
                                  ),
                                  decoration: new BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Color(0xFF26A69A),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        child: Text(
                                          "",
                                          //bmi ?? "",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "BMI",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 15.0,
                                    bottom: 15.0,
                                  ),
                                  decoration: new BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Color(0xFF26A69A),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        child: Text(
                                          "",
                                          //"$heightFeet' $heightInch\"" ?? "",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFFFFFFF),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Height",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 15.0,
                                    bottom: 15.0,
                                  ),
                                  decoration: new BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Color(0xFF26A69A),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        child: RichText(
                                          text: TextSpan(
                                            //text: weight ?? "",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFFFFFFF),
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'lbs',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Weight",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 550,
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 5.0,
                  ),
                  child: Wrap(children: <Widget>[
                    // Text(
                    //   'Hello World',
                    //   style: TextStyle(color: Colors.white),
                    // ),
                    Container(
                        height: 300,
                        child: Column(
                          children: [TextField()],
                        )),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
