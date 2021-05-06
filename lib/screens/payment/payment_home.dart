import 'package:famdoc_user/providers/request_provider.dart';
import 'package:famdoc_user/screens/payment/create_new_card.dart';
import 'package:famdoc_user/screens/payment/razorpay/razorpay_payment_screen.dart';
import 'package:famdoc_user/screens/payment/stripe_payment/existing-cards.dart';
import 'package:famdoc_user/services/payment/stripe_payment-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class PaymentHome extends StatefulWidget {
  static const String id = 'Payment-home';
  PaymentHome({Key key}) : super(key: key);

  @override
  PaymentHomeState createState() => PaymentHomeState();
}

class PaymentHomeState extends State<PaymentHome> {
  onItemPress(BuildContext context, int index, amount, requestProvider) async {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, CreateNewCreditCard.id);

        break;
      case 1:
        payViaNewCard(context, amount, requestProvider);
        break;
      case 2:
        Navigator.pushNamed(context, ExistingCardsPage.id);
        break;
    }
  }

  payViaNewCard(
      BuildContext context, amount, RequestProvider requestProvider) async {
    await EasyLoading.show(status: 'Please Wait..');
    var response = await StripeService.payWithNewCard(
        amount: '${amount}00', currency: 'INR');
    if (response.success == true) {
      requestProvider.success = true;
    }
    await EasyLoading.dismiss();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          content: Text(response.message),
          duration: new Duration(
              milliseconds: response.success == true ? 1200 : 3000),
        ))
        .closed
        .then((_) {
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final requestProvider = Provider.of<RequestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Material(
              elevation: 4,
              child: SizedBox(
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    top: 10,
                  ),
                  child: Image.network(
                      'https://res.cloudinary.com/people-matters/image/upload/fl_immutable_cache,w_624,h_351,q_auto,f_auto/v1597663389/1597663388.jpg',
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                top: 8,
                bottom: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor)),
                        onPressed: () {
                          Navigator.pushNamed(context, RazorPaymentScreen.id);
                        },
                        child: Text('Proceed to payment')),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Material(
              elevation: 4,
              child: SizedBox(
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    top: 10,
                  ),
                  child: Image.network(
                    'https://www.wisdom-drops.com/wp-content/uploads/2017/02/paypal-logo.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Material(
              elevation: 4,
              child: SizedBox(
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    top: 10,
                  ),
                  child: Image.network(
                    'https://stripe.com/img/v3/newsroom/social.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Icon icon;
                    Text text;

                    switch (index) {
                      case 0:
                        icon =
                            Icon(Icons.add_circle, color: theme.primaryColor);
                        text = Text('Add Cards');
                        break;
                      case 1:
                        icon = Icon(Icons.payment_outlined,
                            color: theme.primaryColor);
                        text = Text('Pay via new card');
                        break;
                      case 2:
                        icon =
                            Icon(Icons.credit_card, color: theme.primaryColor);
                        text = Text('Pay via existing card');
                        break;
                    }

                    return InkWell(
                      onTap: () {
                        onItemPress(context, index, requestProvider.amount,
                            requestProvider);
                      },
                      child: ListTile(
                        title: text,
                        leading: icon,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        color: theme.primaryColor,
                      ),
                  itemCount: 3),
            ),
          ],
        ),
      ),
    );
  }
}
