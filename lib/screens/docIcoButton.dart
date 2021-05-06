
import 'package:famdoc_user/widgets/available_doctors.dart';
import 'package:famdoc_user/widgets/image_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DocIcoButton extends StatefulWidget {
  @override
  _DocIcoButtonState createState() => _DocIcoButtonState();
}

class _DocIcoButtonState extends State<DocIcoButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      appBar: AppBar(
        title: Text('Available Doctors '),
        centerTitle: true,
          actions: [
        IconButton(icon: Icon(CupertinoIcons.search), onPressed: () {}),
      ],
      ),
      body: SingleChildScrollView(
              child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
             
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    ImageSlider(),
                    Container(child: AvailableDoctors()),
                  ],
                ),
              ),
              
              ],
            ),
      ),
      
    );
  }
}
