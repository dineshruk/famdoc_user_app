import 'package:famdoc_user/widgets/top_near_doctors.dart';
import 'package:flutter/material.dart';

class New extends StatefulWidget {
  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<New> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NearDoctors(),


      
    );
  }
}