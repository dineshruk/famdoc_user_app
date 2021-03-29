import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/providers/location_provider.dart';
import 'package:famdoc_user/screens/home_screen.dart';
import 'package:famdoc_user/screens/map_screen.dart';
import 'package:famdoc_user/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String smsOtp;
  String verificationId;
  String error;
  UserServices _userServices = UserServices();
  bool loading = false;
  LocationProvider locationData = LocationProvider();
  String screen;
  double latitude;
  double longitude;
  String address;

  Future<void> verifyPhone({
    BuildContext context,
    String number,
  }) async {
    this.loading = true;
    notifyListeners();
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      this.loading = false;
      notifyListeners();
      await _auth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      this.loading = false;
      print(e.code);
      this.error = e.toString();
      notifyListeners();
    };

    final PhoneCodeSent smsOtpSend = (String verId, int resendToken) async {
      this.verificationId = verId;

      //dialog to enter received OTP SMS
      smsOtpDialog(context, number);
    };
    try {
      _auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: smsOtpSend,
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
          });
    } catch (e) {
      this.error = e.toString();
      this.loading = false;
      notifyListeners();
      print(e);
    }
  }

  Future<bool> smsOtpDialog(BuildContext context, String number) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Text(
                  'Verification Code',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 179, 134, 1.0),
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Enter 6 Digit OTP Received as SMS',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            content: Container(
              height: 85,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  this.smsOtp = value;
                },
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId, smsCode: smsOtp);

                      final User user = (await _auth
                              .signInWithCredential(phoneAuthCredential))
                          .user;

                      if (user != null) {
                        this.loading = false;
                        notifyListeners();
                        _userServices.getUserById(user.uid).then((snapShot) {
                          if (snapShot.exists) {
                            if (this.screen == 'Login') {
                              //need to check user data lready exist o not
                              //if exists data will update or create new data
                              Navigator.pushReplacementNamed(
                                  context, HomeScreen.id);
                            } else {
                              updateUser(
                                  id: user.uid, number: user.phoneNumber);
                              Navigator.pushReplacementNamed(
                                  context, HomeScreen.id);
                            }
                          } else {
                            _createUser(id: user.uid, number: user.phoneNumber);
                            Navigator.pushReplacementNamed(
                                context, HomeScreen.id);
                          }
                        });
                      } else {
                        print('Login Failed');
                      }
                    } catch (e) {
                      this.error = 'Invalid OTP';
                      notifyListeners();
                      print(e.toString());
                      showAlertDialog(context);
                      //Navigator.of(context).pop();
                    }
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 25,
                      ),
                    ),
                  )),
            ],
          );
        }).whenComplete(() {
      this.loading = false;
      notifyListeners();
    });
  }

  void _createUser({
    String id,
    String number,
  }) {
    _userServices.createUserData({
      'id': id,
      'number': number,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'address': this.address
    });
    this.loading = false;
    notifyListeners();
  }

  Future<bool> updateUser({
    String id,
    String number,
  }) async{
    try {
      _userServices.updateUserData({
        'id': id,
        'number': number,
        'latitude': this.latitude,
        'longitude': this.longitude,
        'address': this.address
      });
      this.loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error $e');
      return false;
    }
  }

// showAlertDialog(BuildContext context) {
//   // set up the button
//   Widget okButton = FlatButton(
//     child: Text("OK",textAlign: TextAlign.center,),

//     onPressed: () {
//       Navigator.of(context).pop();
//     },
//   );

//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Text("Invalid OTP",style: TextStyle(color: Colors.redAccent),textAlign: TextAlign.center,),
//     content: Text("Please recheck your OTP",textAlign: TextAlign.center,),
//     actions: [
//       okButton,
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

  showAlertDialog(BuildContext context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Invalid OTP",
      desc: "Please Re-Check OTP Code We Provided.",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(20),
        ),
      ],
    ).show();
  }
}
