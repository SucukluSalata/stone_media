import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stonemedia/ui/StoneWorld.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class StoneWorldBook extends StatefulWidget {
  @override
  StoneWorldBookState createState() => StoneWorldBookState();
}

class StoneWorldBookState extends State<StoneWorldBook> {
  final Firestore fireStoreRef = Firestore.instance;
  String link;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  myAppBar() {
    return AppBar(
      title: Text("Book"),
    );
  }

  @override
  Widget build (BuildContext context) {
    print(StoneWorldHomeState.GonderLink);
    return Scaffold(
      body: Center(
        child: Container(
          child: WebView(
            initialUrl: StoneWorldHomeState.GonderLink,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://stoneworldtr.com/e-dergi/')) {
                Navigator.popAndPushNamed(context, "/StoneWorld");
                return NavigationDecision.prevent;
              }else if(request.url.startsWith("https://www.youtube.com/")){
                print(request.url);
                launch(request.url);
                return NavigationDecision.prevent;
              }else if(request.url.startsWith("")){
                print("boş ${request.url}");
                launch(request.url);
                return NavigationDecision.prevent;
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


