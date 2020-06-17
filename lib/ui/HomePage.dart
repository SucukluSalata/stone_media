import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Query worldFireStoreRef = Firestore.instance
      .collection("StoneWorld")
      .orderBy("siralama", descending: true);
  Query techFireStoreRef = Firestore.instance
      .collection("StoneTech")
      .orderBy("siralama", descending: true);

  List worldurlList = [];
  List techurlList = [];

  bool trigger=true;

  @override
  void initState() {
    getDocs();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  Future getDocs() async {
    QuerySnapshot worldSnapshot = await worldFireStoreRef.getDocuments();
    QuerySnapshot techSnapshot = await techFireStoreRef.getDocuments();

    //WORLD GETİR-----------------
    for (int i = 0; i < worldSnapshot.documents.length; i++) {
      if (i == 0) {
        var a = worldSnapshot.documents[i];
        String fotourl;
        fotourl = await Firestore.instance
            .collection("StoneWorld")
            .document(a.documentID)
            .get()
            .then((ds) {
          fotourl = ds["kapakurl"];

          assert(fotourl is String);
          setState(() {
            worldurlList.add(fotourl);
          });
          return fotourl;
        });
      } else {}
    }

    //TECH GETİR------------------
    for (int i = 0; i < techSnapshot.documents.length; i++) {
      if (i == 0) {
        var a = techSnapshot.documents[i];
        String fotourl;
        fotourl = await Firestore.instance
            .collection("StoneTech")
            .document(a.documentID)
            .get()
            .then((ds) {
          fotourl = ds["kapakurl"];

          assert(fotourl is String);
          setState(() {
            techurlList.add(fotourl);
            trigger=false;

          });
          return fotourl;
        });
      } else {}
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: trigger? Container(color: Color.fromRGBO(221, 14, 30, 1),
        child: Center(child: Image.asset("images/duzkarelogo.png",width: MediaQuery.of(context).size.width/3,)),
      ): Container(
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2,
              color: Color.fromRGBO(162, 183, 184,1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, "/StoneWorldHome");
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 2,
                            ),
                          ),
                          Image.network(
                            worldurlList[0],
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                            width: MediaQuery.of(context).size.width / 2,
                          )
                        ],
                      ),
                    ),
                    FlatButton(
                      color: Color.fromRGBO(196, 202, 204, 1),
                      child: Text("Stone World"),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/StoneWorldHome");
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              color: Color.fromRGBO(195, 218, 219,1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, "/StoneTechHome");
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 2,
                            ),
                          ),
                          Image.network(
                            techurlList[0],
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                            width: MediaQuery.of(context).size.width / 2,
                          )
                        ],
                      ),
                    ),
                    FlatButton(
                      color: Color.fromRGBO(196, 202, 204, 1),
                      child: Text("Stone Tech"),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, "/StoneTechHome");
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
