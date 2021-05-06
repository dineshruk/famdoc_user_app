import 'package:famdoc_user/providers/addProvider.dart';
import 'package:famdoc_user/providers/auth_provider.dart';
import 'package:famdoc_user/providers/coupon_provider.dart';
import 'package:famdoc_user/providers/doctor_provider.dart';
import 'package:famdoc_user/providers/location_provider.dart';
import 'package:famdoc_user/providers/request_provider.dart';
import 'package:famdoc_user/screens/add_list_screen.dart';
import 'package:famdoc_user/screens/doctor_home_screen.dart';
import 'package:famdoc_user/screens/edit_profile.dart';
import 'package:famdoc_user/screens/home_screen.dart';
import 'package:famdoc_user/screens/landing_screen.dart';
import 'package:famdoc_user/screens/login_screen.dart';
import 'package:famdoc_user/screens/map_screen.dart';
import 'package:famdoc_user/screens/my_buy_packages.dart';
import 'package:famdoc_user/screens/new_Edit_profile.dart';
import 'package:famdoc_user/screens/package_details_screen.dart';
import 'package:famdoc_user/screens/package_list_screen.dart';
import 'package:famdoc_user/screens/payment/create_new_card.dart';
import 'package:famdoc_user/screens/payment/credit_card_list.dart';
import 'package:famdoc_user/screens/payment/razorpay/razorpay_payment_screen.dart';
import 'package:famdoc_user/screens/payment/stripe_payment/existing-cards.dart';
import 'package:famdoc_user/screens/payment/payment_home.dart';
import 'package:famdoc_user/screens/profile_update_screen.dart';
import 'package:famdoc_user/widgets/packages/package_list_widget.dart';
import 'package:famdoc_user/screens/profile.dart';
import 'package:famdoc_user/screens/splash_screen.dart';
import 'package:famdoc_user/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DoctorProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => AddProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => CouponProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RequestProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF26A69A),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        MapScreen.id: (context) => MapScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ProfilePage.id: (context) => ProfilePage(),
        EditProfileScreen.id: (context) => EditProfileScreen(),
        LandingScreen.id: (context) => LandingScreen(),
        DoctorHomeScreen.id: (context) => DoctorHomeScreen(),
        PackageListWidget.id: (context) => PackageListWidget(),
        PackageListScreen.id: (context) => PackageListScreen(),
        PackageDetailsScreen.id: (context) => PackageDetailsScreen(),
        AddScreen.id: (context) => AddScreen(),
        NewEditProfileScreen.id : (context) => NewEditProfileScreen(),
        UpdateProfile.id : (context) => UpdateProfile(),
        ExistingCardsPage.id : (context)=> ExistingCardsPage(),
        PaymentHome.id : (context)=> PaymentHome(),
        MyBuyPackages.id : (context)=> MyBuyPackages(),
        CreditCardList.id : (context)=> CreditCardList(),
        CreateNewCreditCard.id : (context)=> CreateNewCreditCard(),
        RazorPaymentScreen.id : (context)=> RazorPaymentScreen(),
      },
      builder: EasyLoading.init(),
    );
  }
}
