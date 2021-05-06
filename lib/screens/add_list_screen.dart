import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/providers/addProvider.dart';
import 'package:famdoc_user/providers/auth_provider.dart';
import 'package:famdoc_user/providers/coupon_provider.dart';
import 'package:famdoc_user/providers/location_provider.dart';
import 'package:famdoc_user/providers/request_provider.dart';
import 'package:famdoc_user/screens/map_screen.dart';
import 'package:famdoc_user/screens/new_Edit_profile.dart';
import 'package:famdoc_user/screens/payment/payment_home.dart';
import 'package:famdoc_user/services/add_services.dart';
import 'package:famdoc_user/services/doctor_service.dart';
import 'package:famdoc_user/services/hire_request_service.dart';
import 'package:famdoc_user/services/user_services.dart';
import 'package:famdoc_user/widgets/add/add_list.dart';
import 'package:famdoc_user/widgets/add/cod_toggle.dart';
import 'package:famdoc_user/widgets/add/coupan_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddScreen extends StatefulWidget {
  static const String id = 'Add-screen';
  final DocumentSnapshot document;
  AddScreen({this.document});
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  DoctorService _doctor = DoctorService();
  UserServices _userServices = UserServices();
  RequestServices _requestServices = RequestServices();
  AddServices _addServices = AddServices();
  User user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot doc;
  var textStyle = TextStyle(
    color: Colors.grey,
  );

  int visitingFee = 800;
  String _location = '';
  String _address = '';
  bool _loading = false;
  bool _checkingUser = false;
  double discount = 0;

  @override
  void initState() {
    getPrefs();
    _doctor.getDoctorDetails(widget.document.data()['docUid']).then((value) {
      setState(() {
        doc = value;
      });
    });
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

  @override
  Widget build(BuildContext context) {
    var _addProvider = Provider.of<AddProvider>(context);
    final locationData = Provider.of<LocationProvider>(context);
    var userDetails = Provider.of<AuthProvider>(context);
    var _coupon = Provider.of<CouponProvider>(context);
    userDetails.getUserDetails().then((value) {
      double subTotal = _addProvider.subTotal;
      double discountRate = _coupon.discountRate / 100;
      setState(() {
        discount = subTotal * discountRate;
      });
    });

    var _payable = _addProvider.subTotal + visitingFee - discount;
    final requestProvider = Provider.of<RequestProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      bottomSheet: userDetails.snapshot == null
          ? Container()
          : Container(
              height: 140,
              color: Colors.blueGrey[900],
              child: Column(
                children: [
                  Container(
                    // padding: EdgeInsets.only(bottom: 40),
                    height: 80,
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Visit to this address :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _loading = true;
                                    });
                                    locationData
                                        .getCurrentPosition()
                                        .then((value) {
                                      setState(() {
                                        _loading = false;
                                      });
                                      if (value != null) {
                                        Navigator.pushReplacementNamed(
                                            context, MapScreen.id);
                                      } else {
                                        setState(() {
                                          _loading = false;
                                        });
                                        print('Permission not allowed');
                                      }
                                    });
                                  },
                                  child: _loading
                                      ? CircularProgressIndicator()
                                      : Text(
                                          'Change',
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 13),
                                        ),
                                )
                              ],
                            ),
                            Text(
                              userDetails.snapshot.data()['firstName'] != null
                                  ? '${userDetails.snapshot.data()['firstName']} ${userDetails.snapshot.data()['lastName']} : $_location, $_address'
                                  : '$_location, $_address',
                              maxLines: 3,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\Rs.${_payable.toStringAsFixed(0)}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Including Hire Charge',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 10),
                              )
                            ],
                          ),
                          RaisedButton(
                              child: _checkingUser
                                  ? CircularProgressIndicator()
                                  : Text(
                                      'CHECKOUT',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                              color: Colors.redAccent,
                              onPressed: () {
                                EasyLoading.show(status: 'Please Wait...');
                                _userServices
                                    .getUserById(user.uid)
                                    .then((value) {
                                  if (value.data()['firstName'] == null) {
                                    EasyLoading.dismiss();
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              Duration(milliseconds: 400),
                                          transitionsBuilder: (context,
                                              animation, animationTime, child) {
                                            animation:
                                            CurvedAnimation(
                                                parent: animation,
                                                curve: Curves.elasticInOut);
                                            return ScaleTransition(
                                              alignment: Alignment.bottomRight,
                                              scale: animation,
                                              child: child,
                                            );
                                          },
                                          pageBuilder: (context, animation,
                                              animationTime) {
                                            return NewEditProfileScreen();
                                          },
                                        ));
                                  } else {
                                    EasyLoading.dismiss();
                                    //EasyLoading.show(status: 'Please wait...');
                                    if (_addProvider.cod == false) {
                                      //pay_online

                                      requestProvider.totalAmount(
                                        _payable,
                                        widget.document.data()['docName'],
                                        userDetails.snapshot.data()['email'],
                                      );
                                      Navigator.pushNamed(
                                              context, PaymentHome.id)
                                          .whenComplete(() {
                                        if (requestProvider.success == true) {
                                          _saveRequest(_addProvider, _payable,
                                              _coupon, requestProvider);
                                        }
                                      });
                                    } else {
                                      //pay_after_visit
                                      _saveRequest(_addProvider, _payable,
                                          _coupon, requestProvider);
                                    }
                                  }
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBozIsSxrolled) {
            return [
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0.0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${widget.document.data()['docName']}',
                      style: TextStyle(fontSize: 17),
                    ),
                    Row(
                      children: [
                        Text(
                          'You Select ${_addProvider.addQty} ${_addProvider.addQty > 1 ? 'Packages,' : 'Package,'} ',
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[50]),
                        ),
                        Text(
                          'To Pay Rs.${_payable.toStringAsFixed(0)} ',
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[50]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ];
          },
          body: doc == null
              ? Center(child: CircularProgressIndicator())
              : _addProvider.addQty > 0
                  ? SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 80),
                      physics: const NeverScrollableScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  ListTile(
                                    tileColor: Colors.white,
                                    leading: Container(
                                        height: 60,
                                        width: 60,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            doc.data()['imageURL'],
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                    title: Text('Dr. ${doc.data()['docName']}'),
                                    subtitle: Text(
                                      doc.data()['address'],
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  CodToggleSwitch(),
                                  Divider(
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ),

                            AddList(
                              document: widget.document,
                            ),

                            //coupon

                            CouponWidget(doc.data()['uid']),
                            //bill detail card
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 4, bottom: 80),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Bill Details',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Package List Value  :',
                                                style: textStyle,
                                              ),
                                            ),
                                            Text(
                                              'Rs. ${_addProvider.subTotal.toStringAsFixed(0)}',
                                              style: textStyle,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        if (discount > 0)
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Discount  :',
                                                  style: textStyle,
                                                ),
                                              ),
                                              Text(
                                                'Rs. ${discount.toStringAsFixed(0)}',
                                                style: textStyle,
                                              )
                                            ],
                                          ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Visiting Fee  :',
                                                style: textStyle,
                                              ),
                                            ),
                                            Text(
                                              'Rs. $visitingFee',
                                              style: textStyle,
                                            )
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.grey[800],
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Expanded(
                                        //       child: Text(
                                        //         'Total Amount Payable  :',
                                        //         style:
                                        //             TextStyle(fontWeight: FontWeight.bold),
                                        //       ),
                                        //     ),
                                        //     Text(
                                        //       'Rs. ${_payable.toStringAsFixed(0)}',
                                        //       style: TextStyle(fontWeight: FontWeight.bold),
                                        //     )
                                        //   ],
                                        // ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(.2),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text('Total Amount',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.teal[800],
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Text(
                                                  'Rs. ${_payable.toStringAsFixed(0)}',
                                                  style: TextStyle(
                                                      color: Colors.teal[800],
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child:
                          Text('Empty Package List,Continue Adding Packages'),
                    )),
    );
  }

  _saveRequest(AddProvider addProvider, payable, CouponProvider coupon,
      RequestProvider requestProvider) {
    _requestServices.saveRequest({
      'packages': addProvider.addList,
      'userId': user.uid,
      'visitingFee': visitingFee,
      'total': payable,
      'discount': discount.toStringAsFixed(0),
      'cod': addProvider.cod,
      'discountCode':
          coupon.document == null ? null : coupon.document.data()['title'],
      'doctor': {
        'docName': widget.document.data()['docName'],
        'docId': widget.document.data()['docUid'],
      },
      //'details':widget.document.data()['subCategory'],
      'timestamp': DateTime.now().toString(),
      'orderStatus': 'Requested',
      'visitingDoc': {
        'name': '',
        'phone': '',
        'location': '',
      }
    }).then((value) {
      requestProvider.success = false;
      _addServices.deleteData().then((value) {
        _addServices.checkData().then((value) {
          EasyLoading.showSuccess('Your Buying Package Is Submitted');
          Navigator.pop(context);
        });
      });
    });
  }
}
