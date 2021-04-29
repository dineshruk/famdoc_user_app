

import 'package:famdoc_user/widgets/add/addNotification.dart';
import 'package:famdoc_user/widgets/category_widget.dart';
import 'package:famdoc_user/widgets/doctor_appbar.dart';
import 'package:famdoc_user/widgets/doctor_banner.dart';
import 'package:famdoc_user/widgets/packages/both_package.dart';
import 'package:famdoc_user/widgets/packages/onlineCon_package.dart';
import 'package:famdoc_user/widgets/packages/visit_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorHomeScreen extends StatelessWidget {
  static const String id = 'Doctor-Home-Screen';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 1,right: 1,),
        child: AddNotification(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              DoctorAppBar(),
            ];
          },
          body: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              DoctorBanner(),
              DoctorCategory(),
              OnlineConsultPackage(),
              VisitPackage(),
              BothPackage(),
            
            ],
          )),
    );
  }
}
