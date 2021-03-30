import 'package:famdoc_user/providers/auth_provider.dart';
import 'package:famdoc_user/providers/location_provider.dart';
import 'package:famdoc_user/screens/map_screen.dart';
import 'package:famdoc_user/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome-screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    bool _validPhoneNumber = false;
    var _phoneNumberController = TextEditingController();

    void showBottomSheet(context) {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) =>
            StatefulBuilder(builder: (context, StateSetter myState) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: auth.error == 'Invalid OTP' ? true : false,
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            auth.error != null ? auth.error : '',
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 179, 134, 1.0)),
                  ),
                  Text(
                    'Enter your mobile number to process',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 179, 134, 1.0)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      prefixText: '+94',
                      labelText: '9 Digit Mobile Number',
                    ),
                    controller: _phoneNumberController,
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    maxLength: 9,
                    onChanged: (value) {
                      if (value.length == 9) {
                        myState(() {
                          _validPhoneNumber = true;
                        });
                      } else {
                        myState(() {
                          _validPhoneNumber = false;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AbsorbPointer(
                          absorbing: _validPhoneNumber ? false : true,
                          child: FlatButton(
                            onPressed: () {
                              myState(() {
                                auth.loading = true;
                              });
                              String number =
                                  '+94${_phoneNumberController.text}';
                              auth
                                  .verifyPhone(context: context, number: number)
                                  .then((value) {
                                _phoneNumberController.clear();
                              });
                            },
                            color: _validPhoneNumber
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            child: auth.loading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : Text(
                                    _validPhoneNumber
                                        ? 'CONTINUE'
                                        : 'ENTER PHONE NUMBER',
                                    style: TextStyle(color: Colors.white),
                                  ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ).whenComplete(() {
        setState(() {
          auth.loading = false;
          _phoneNumberController.clear();
        });
      });
    }

    final locationData = Provider.of<LocationProvider>(context, listen: false);

    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Positioned(
                right: 0.0,
                top: 10.0,
                child: FlatButton(
                  child: Text('SKIP',
                      style:
                          TextStyle(color: Color.fromRGBO(0, 179, 134, 1.0))),
                  onPressed: () {},
                ),
              ),
              Column(children: [
                Expanded(child: OnBoardScreen()),
                Text(
                  'Ready to connect with your nearest Doctor',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  color: Color.fromRGBO(0, 179, 134, 1.0),
                  child: locationData.loading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Set Your Location',
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: () async {
                    setState(() {
                      locationData.loading = true;
                    });

                    await locationData.getCurrentPosition();
                    if (locationData.permissionAllowed == true) {
                      Navigator.pushReplacementNamed(context, MapScreen.id);
                      setState(() {
                        locationData.loading = false;
                      });
                    } else {
                      print('Permission Not Allowed');
                      setState(() {
                        locationData.loading = false;
                      });
                    }
                  },
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.green[600],
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(30)),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: FlatButton(
                    child: RichText(
                      text: TextSpan(
                          text: 'Already a User ?',
                          style: TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                                text: '  Login',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(0, 179, 134, 1.0)))
                          ]),
                    ),
                    onPressed: () {
                      setState(() {
                        auth.screen = 'Login';
                      });
                      showBottomSheet(context);
                    },
                  ),
                ),
              ])
            ],
          )),
    );
  }
}
