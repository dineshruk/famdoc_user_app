import 'package:famdoc_user/providers/doctor_provider.dart';
import 'package:famdoc_user/widgets/doctor_appbar.dart';
import 'package:famdoc_user/widgets/packages/package_filter_widget.dart';
import 'package:famdoc_user/widgets/packages/package_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackageListScreen extends StatelessWidget {
  static const String id = 'package-list-screen';
  @override
  Widget build(BuildContext context) {
    var _doctorProvider = Provider.of<DoctorProvider>(context);
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            floating: true,
            snap: true,
              title: Text(
                _doctorProvider.selectedPackageCategory,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.white),
              expandedHeight: 110,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(top: 88),
                child: Container(
                  height: 56,
                  color: Colors.grey,
                  child: PackageFilterWidget(),
                ),
              )),
        ];
      },
      body: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          PackageListWidget(),
        ],
      ),
    ));
  }
}
