import 'package:famdoc_user/providers/auth_provider.dart';
import 'package:famdoc_user/providers/location_provider.dart';
import 'package:famdoc_user/screens/map_screen.dart';
import 'package:famdoc_user/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  static const String id = 'edit-profile';
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _location = '';
  String _address = '';
  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String location = prefs.getString('location');
    String address = prefs.getString('address');
    setState(() {
      _location = location;
      _address = address;
    });
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final locationData = Provider.of<LocationProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: kAppPrimaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, 0.0),
            end: Alignment(1.0, 0.0),
            colors: [const Color(0xffbce6eb), const Color(0xFF26A69A)],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.black,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 400),
                                  transitionsBuilder: (context, animation,
                                      animationTime, child) {
                                    //animation:
                                    CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.elasticInOut);
                                    return ScaleTransition(
                                      alignment: Alignment.topLeft,
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation, animationTime) {
                                    return ProfilePage();
                                  },
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 623,
                    color: Colors.transparent,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 20, right: 20),
                        child: Container(
                            height: 900,
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  buildNameFormField(),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  buildPhoneFormField(),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  buildEmailFormField(),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  buildAgeFormField(),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      locationData.getCurrentPosition();
                                      if (locationData.permissionAllowed ==
                                          true) {
                                        Navigator.pushReplacementNamed(
                                            context, MapScreen.id);
                                      } else {
                                        print('Permission not allowed');
                                      }
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                _location == null
                                                    ? 'Address Not Set'
                                                    : _location,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blueAccent),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 165,
                                            ),
                                            Icon(Icons.edit_outlined)
                                          ],
                                        ),
                                        Text(_address == null
                                            ? 'Address Not Set'
                                            : _address),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FlatButton(
                                        child: Text('Change Your Location'),
                                        onPressed: () {},
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.green[600],
                                                width: 3,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      FlatButton(
                                        child: Text('Save'),
                                        onPressed: () {},
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.green[600],
                                                width: 3,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextFormField buildNameFormField() {
  return TextFormField(
    obscureText: false,
    //controller: nameTextEditingController,
    validator: (val) {
      return val.isEmpty || val.length < 4 ? "Please enter a name" : null;
    },
    decoration: InputDecoration(
      labelText: "Name",
      hintText: "Enter your name here",
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 42,
        vertical: 20,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.green[600]),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.blue[900]),
        gapPadding: 10,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.blue[900]),
        gapPadding: 10,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.blue[900]),
        gapPadding: 10,
      ),
      //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
    ),
  );
}

TextFormField buildPhoneFormField() {
  return TextFormField(
    obscureText: false,
    //controller: nameTextEditingController,
    validator: (val) {
      return val.isEmpty || val.length < 4 ? "Please enter a name" : null;
    },
    decoration: InputDecoration(
      labelText: "Name",
      hintText: "Enter your name here",
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 42,
        vertical: 20,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.green[600]),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.blue[900]),
        gapPadding: 10,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.blue[900]),
        gapPadding: 10,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.blue[900]),
        gapPadding: 10,
      ),
      //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
    ),
  );
}

TextFormField buildEmailFormField() {
  return TextFormField(
    obscureText: false,
    //controller: nameTextEditingController,
    validator: (val) {
      return val.isEmpty || val.length < 4 ? "Please enter a name" : null;
    },
    decoration: InputDecoration(
      labelText: "Name",
      hintText: "Enter your name here",
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 42,
        vertical: 20,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.green[600]),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.blue[900]),
        gapPadding: 10,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.blue[900]),
        gapPadding: 10,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.blue[900]),
        gapPadding: 10,
      ),
      //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
    ),
  );
}

TextFormField buildAgeFormField() {
  return TextFormField(
    obscureText: false,
    //controller: nameTextEditingController,
    validator: (val) {
      return val.isEmpty || val.length < 4 ? "Please enter a name" : null;
    },
    decoration: InputDecoration(
      labelText: "Name",
      hintText: "Enter your name here",
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 42,
        vertical: 20,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.green[600]),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.blue[900]),
        gapPadding: 10,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.blue[900]),
        gapPadding: 10,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide(color: Colors.blue[900]),
        gapPadding: 10,
      ),
      //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
    ),
  );
}
