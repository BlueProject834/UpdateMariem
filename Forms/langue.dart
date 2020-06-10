import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvmakerapp/classes/Langue.dart';
import 'package:cvmakerapp/finFormulaire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../drawer.dart';

class LangueCv extends StatelessWidget {
  final db = Firestore.instance;
  final Langue langue;

  LangueCv({Key key, this.langue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newLangue = new Langue(null, null);
    TextEditingController _titleController1 = new TextEditingController();
    TextEditingController _titleController2 = new TextEditingController();
    _titleController1.text = langue.langue;
    // final newCompetence = new Competence(_titleController1.text, _titleController2.text);

    return Scaffold(
        appBar: AppBar(
          title: Text('Langues'),
        ),
        endDrawer: drawer(),
        body: Center(
            child: SingleChildScrollView(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Langue:"),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController1,
                autofocus: true,
              ),
            ),
            Text("Niveau:"),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController2,
                autofocus: true,
              ),
            ),

            ClipOval(
              child: Material(
                color: Hexcolor('#774781'), // button color
                child: InkWell(
                  //splashColor: Colors.red, // inkwell color
                  child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                  onTap: () async {
                    langue.langue = _titleController1.text;
                    langue.niveau = _titleController2.text;
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    final FirebaseUser user = await _auth.currentUser();
                    final uid = user.uid;
                    await db
                        .collection("userData")
                        .document(uid)
                        .collection("Cv")
                        .document(uid)
                        .collection("Langues")
                        .document("1")
                        .setData(langue.toJson());

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new LangueCv(
                                  langue: newLangue,
                                )));
                  },
                ),
              ),
            ),
            SizedBox(height: 30.0),
            RaisedButton(
              child: Text("Enregistrer et terminer"),
              onPressed: () async {
                langue.langue = _titleController1.text;
                langue.niveau = _titleController2.text;
                final FirebaseAuth _auth = FirebaseAuth.instance;
                final FirebaseUser user = await _auth.currentUser();
                final uid = user.uid;
                await db
                    .collection("userData")
                    .document(uid)
                    .collection("Cv")
                    .document(uid)
                    .collection("Langues")
                    .document("2")
                    .setData(langue.toJson());

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new pageFinFormulaire()));
              },
            ),
            RaisedButton(
              child: Text("Ignorer et terminer"),
              onPressed: () async {
                langue.langue = _titleController1.text;
                langue.niveau = _titleController2.text;

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new pageFinFormulaire()));
              },
            ),
          ],
        ))));
  }
}
