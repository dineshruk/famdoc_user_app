import 'package:famdoc_user/providers/addProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_bar/toggle_bar.dart';

class CodToggleSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _add = Provider.of<AddProvider>(context);
    return Container(
      color: Colors.white,
      child: ToggleBar(
          backgroundColor: Colors.grey[300],
          textColor: Colors.grey[600],
          selectedTabColor: Theme.of(context).primaryColor,
          labels: [
            "Pay Online",
            "Pay After Visit",
          ],
          onSelectionUpdated: (index) {
            _add.getPaymentMethod(index);
          }),
    );
  }
}
