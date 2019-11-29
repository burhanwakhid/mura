import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatelessWidget {
  final title;
  final url;
  
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  NewsDetail({Key key, @required this.title,@required this.url}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue[100]),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
        // leading: IconButton(
        //   padding: EdgeInsets.only(left: 30.0),
        //   onPressed: () {
        //     // _buildDrawer();
        //   },
        //   icon: Icon(Icons.menu),
        //   iconSize: 30.0,
        //   color: Colors.black,
        // ),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}