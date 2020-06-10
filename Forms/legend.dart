import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvmakerapp/Forms/CentreInteret.dart';
import 'package:cvmakerapp/classes/Interet.dart';
import 'package:cvmakerapp/classes/Legend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../drawer.dart';

class LegendCv extends StatelessWidget {
  final db = Firestore.instance;

  final Legend legend;

  LegendCv({Key key, @required this.legend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newInteret = new Interet(null, null);
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = legend.legend;
    final newLegend = new Legend(_titleController.text);

    return Scaffold(
        appBar: AppBar(
          title: Text('Légende Cv'),
        ),
        endDrawer: drawer(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Entrer une légende pour votre cv"),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController,
                autofocus: true,
              ),
            ),
            RaisedButton(
              child: Text("Enregistrer et passer au suivant"),
              onPressed: () async {
                legend.legend = _titleController.text;
                final FirebaseAuth _auth = FirebaseAuth.instance;
                final FirebaseUser user = await _auth.currentUser();
                final uid = user.uid;
                await db
                    .collection("userData")
                    .document(uid)
                    .collection("Cv")
                    .document(uid)
                    .collection("Légende")
                    .document("1")
                    .setData(legend.toJson());

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CentreInteretCv(interet: newInteret)));
              },
            ),
            RaisedButton(
              child: Text("Passer au suivant sans enregistrer"),
              onPressed: () async {
                legend.legend = _titleController.text;

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CentreInteretCv(interet: newInteret)));
              },
            ),
          ],
        )));
  }
}
