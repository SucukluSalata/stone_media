import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stonemedia/ui/StoneTech.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';


class StoneTechBook extends StatefulWidget{

  @override
  StoneTechBookState createState()=>StoneTechBookState();

}

class StoneTechBookState extends State<StoneTechBook> {
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
  

  @override
  Widget build(BuildContext context) {
    print(StoneTechHomeState.GonderLink);
    return Scaffold(
      body: Center(
        child: Container(
          child: WebView(
            initialUrl: StoneTechHomeState.GonderLink,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://stoneworldtr.com/e-dergi/')) {
                print(request.url);
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