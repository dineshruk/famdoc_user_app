import 'dart:async';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class DrugExplorerPage extends StatefulWidget {

  @override
  _DrugExplorerPageState createState() => _DrugExplorerPageState();

  
}

class _DrugExplorerPageState extends State<DrugExplorerPage> {
  Completer<WebViewController> _completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Drug Explorer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          
            initialUrl:
                'https://predictnewapp.firebaseapp.com/',
                javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _completer.complete(webViewController);
            }),
      ),
    );
  }
}