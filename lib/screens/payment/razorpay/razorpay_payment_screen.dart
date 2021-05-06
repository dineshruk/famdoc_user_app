import 'package:famdoc_user/providers/request_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPaymentScreen extends StatefulWidget {
  static const String id = 'razor-pay';
  @override
  _RazorPaymentScreenState createState() => _RazorPaymentScreenState();
}

class _RazorPaymentScreenState extends State<RazorPaymentScreen> {
  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;
  bool success;

Future<void> openCheckout(RequestProvider requestProvider) async {
    User user = FirebaseAuth.instance.currentUser;
    PaymentSuccessResponse response;

    var options = {
      'key': 'rzp_test_sKTxRaryV5uip4',
      'amount': '${requestProvider.amount}00',
      'name': 'Dr. ${requestProvider.docName}',
      'description': 'Doctor Package Purchase',
      'prefill': {'contact': user.phoneNumber, 'email': requestProvider.email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      success = true;
    });
    //EasyLoading.showSuccess("SUCCESS: " + response.paymentId, );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    EasyLoading.show(
      status: "ERROR: " + response.code.toString() + " - " + response.message,
    );
    EasyLoading.dismiss();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    EasyLoading.show(
      status: "EXTERNAL_WALLET: " + response.walletName,
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Payment Using Razorpay',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Total Amount to pay :\n\Rs.${requestProvider.amount}',
                    textAlign: TextAlign.center),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor)),
                    onPressed: () {
                      openCheckout(requestProvider).whenComplete(() {
                        if (success = true) {
                          requestProvider.paymentStatus(true);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      });
                    },
                    child: Text('Continue',
                        style: TextStyle(color: Colors.white))),
              ],
            )
          ])),
    );
  }
}
