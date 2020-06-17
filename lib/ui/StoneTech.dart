import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class StoneTechHome extends StatefulWidget {
  @override
  StoneTechHomeState createState() => StoneTechHomeState();
}

class StoneTechHomeState extends State<StoneTechHome> {
  String text = "";
  Query fireStoreRef = Firestore.instance
      .collection("StoneTech")
      .orderBy("siralama", descending: true);
  static List<String> urlList = [];
  static List<String> linkList = [];
  static List<String> zamanList = [];
  static List<String> ilanids = [];
  static List<String> sonilanid = [];
  static List<String> sonurlList = [];
  static List<String> sonlinkList = [];
  static List<String> sonzamanList = [];
  static String GonderLink;

  bool trigger = true;

  @override
  void initState() {
    getDocs();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  Future getDocs() async {
    urlList.clear();
    linkList.clear();
    zamanList.clear();
    ilanids.clear();
    sonilanid.clear();
    sonurlList.clear();
    sonlinkList.clear();
    sonzamanList.clear();
    GonderLink = "";

    QuerySnapshot querySnapshot = await fireStoreRef.getDocuments();

    for (int i = 0; i < querySnapshot.documents.length; i++) {
      if (i == 0) {
        var a = querySnapshot.documents[i];
        sonilanid.add(a.documentID);
        String fotourl;
        String link;
        String zaman;
        fotourl = await Firestore.instance
            .collection("StoneTech")
            .document(a.documentID)
            .get()
            .then((ds) {
          fotourl = ds["kapakurl"];
          link = ds["link"];
          zaman = ds["zaman"];

          assert(fotourl is String);
          assert(link is String);
          assert(zaman is String);
          setState(() {
            sonurlList.add(fotourl);
            sonlinkList.add(link);
            sonzamanList.add(zaman);
          });
          return fotourl;
        });
      } else {
        var a = querySnapshot.documents[i];
        ilanids.add(a.documentID);
        String fotourl;
        String link;
        String zaman;
        fotourl = await Firestore.instance
            .collection("StoneTech")
            .document(a.documentID)
            .get()
            .then((ds) {
          fotourl = ds["kapakurl"];
          link = ds["link"];
          zaman = ds["zaman"];

          assert(fotourl is String);
          assert(link is String);
          assert(zaman is String);
          setState(() {
            urlList.add(fotourl);
            linkList.add(link);
            zamanList.add(zaman);
            trigger = false;
          });
          return fotourl;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: trigger
          ? Container(
              color: Colors.white30,
              child: Center(
                child: Image.asset(
                  "images/loadinglittle.gif",
                  scale: MediaQuery.of(context).size.width / 40,
                ),
              ),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  leading:                     Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, "/StoneWorldHome");
                        },
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(pi),
                          child: Icon(
                            Icons.label,
                            size: 30,
                            color: Color.fromRGBO(196, 202, 204, 1),
                          ),
                        ),
                      ))
                  ,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Stone Tech',
                      style: TextStyle(color: Colors.black),
                    ),
                    centerTitle: true,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text(sonzamanList[0])),
                          Row(
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context).size.width / 3 -
                                      5),
                              Container(
                                  child: Center(
                                      child: Image.network(
                                sonurlList[0],
                                width: MediaQuery.of(context).size.width / 3,
                              ))),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 3 - 5,
                                child: Center(
                                    child: IconButton(icon: Icon(Icons.share),color: Colors.black,onPressed: ()=>share(context,sonzamanList[0]),)),
                              )
                            ],
                          ),
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width / 3,
                            child: FlatButton(
                              shape: StadiumBorder(),
                              color: Color.fromRGBO(196, 202, 204, 1),
                              onPressed: () {
                                GonderLink = StoneTechHomeState.sonlinkList[0];
                                Navigator.pushNamed(context, "/StoneTechBook");
                              },
                              child: Text("READ THE LATEST"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "LATEST ISSUES",
                          textAlign: TextAlign.left,
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width / 1.4),
                            child: Divider(
                              color: Colors.yellow,
                              thickness: 3,
                            ))
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.3,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: ilanids.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black)),
                                width: MediaQuery.of(context).size.width / 2.6,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Image.network(
                                            urlList[index],
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Divider(
                                            color: Colors.black,
                                            thickness: 1,
                                          )),
                                      Text(
                                        zamanList[index],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: FlatButton(
                                              color: Color.fromRGBO(196, 202, 204, 1),
                                              onPressed: () {
                                                GonderLink = StoneTechHomeState
                                                    .linkList[index];
                                                Navigator.pushNamed(
                                                    context, "/StoneTechBook");
                                              },
                                              child: Text("READ"),
                                            ),
                                          ),
                                          IconButton(
                                              iconSize: 20,
                                              icon: Icon(Icons.share,color: Colors.black,),
                                              onPressed: () {
                                                Share.share(
                                                    "Stone Tech dergisinin ${zamanList[index]} sayısına bakmalısın! Eğer uygulaması yoksa hemen indir! ");
                                              })
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  share(BuildContext context, String zamani) {
    final RenderBox renderBox = context.findRenderObject();
    final String text =
        "Stone Tech dergisinin $zamani sayısına bakmalısın! Eğer uygulaması yoksa hemen indir! ";
    Share.share(text,
        sharePositionOrigin:
            renderBox.localToGlobal(Offset.zero) & renderBox.size);
  }
/*Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Stone World"),
                          Text(sonzamanList[0]),
                          Container(
                            child: Image(
                              image: NetworkImage(sonurlList[0]),
                              height: MediaQuery.of(context).size.height / 4,
                            ),
                          ),
                          RaisedButton(
                            child: Text("READ"),
                            color: Colors.blue,
                            onPressed: () {
                              GonderLink = StoneWorldHomeState.sonlinkList[0];
                              Navigator.pushNamed(context, "/StoneWorldBook");
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: listem(),
                    ),
                  )
                ],
              )*/
}
