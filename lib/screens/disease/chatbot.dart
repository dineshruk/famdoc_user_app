import 'dart:async';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class ChatbotPage extends StatefulWidget {

  @override
  _ChatbotPageState createState() => _ChatbotPageState();

  
}

class _ChatbotPageState extends State<ChatbotPage> {
  Completer<WebViewController> _completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Disease Prediction',
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
                'https://diseasefamdoc.firebaseapp.com/',
                javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _completer.complete(webViewController);
            }),
      ),
    );
  }
}