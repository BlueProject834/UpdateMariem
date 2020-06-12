import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cvmakerapp/classes/Cv.dart';
import 'package:cvmakerapp/classes/Titre.dart';
import 'package:cvmakerapp/Forms/title.dart';
import 'drawer.dart';
import 'modeleCv2.dart';

class PageModelsCv2 extends StatefulWidget {
  PageModelsCv2({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PageModelsCv2State createState() => _PageModelsCv2State();
}

class _PageModelsCv2State extends State<PageModelsCv2> {

  final db= Firestore.instance;

  static TextEditingController Controller = new TextEditingController();

  final newCv = new Cv(Controller.text);

  String nomModele="";

  @override
  Widget build(BuildContext context) {


    final newTitle = new Titre(null);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Modèles de CV",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "PlayfairDisplay",
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      endDrawer: drawer(),
      body: StreamBuilder(
        stream: Firestore.instance.collection('modele').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("Chargement en cours ...");
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot modele = snapshot.data.documents[index];
                //nomModele = modele['nom'];
                return Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Hexcolor('#800080'),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                )),
                            child: Text(
                              " ${ nomModele=modele['nom']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "PlayfairDisplay",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => pageFinFormulaire2()));
                            },
                            child: Image.network(
                              '${modele['image']}',
                              width: 300,
                              height: 400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  void createRecord() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    await db.collection("userData")
        .document(uid).collection("Cv").document(uid).setData({
      'nomCv': newCv.nomCV,
      'modeleCv': nomModele,
    });
  }



}