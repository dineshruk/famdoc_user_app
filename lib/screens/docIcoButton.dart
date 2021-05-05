import 'package:famdoc_user/widgets/available_doctors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DocIcoButton extends StatefulWidget {
  @override
  _DocIcoButtonState createState() => _DocIcoButtonState();
}

class _DocIcoButtonState extends State<DocIcoButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Near By Doctors'),
        
      ),
      body: SingleChildScrollView(
              child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
              Container(
                height: 80,
                color: Colors.grey[600],
                child: Icon(FontAwesomeIcons.search),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: AvailableDoctors(),
              ),
              
              ],
            ),
      )
    );
  }
}
