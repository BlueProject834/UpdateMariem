import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvmakerapp/classes/Langue.dart';
import 'package:cvmakerapp/classes/Projet.dart';
import 'package:cvmakerapp/Forms/langue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../drawer.dart';

class ProjetCv extends StatelessWidget {

  final db = Firestore.instance;
  final Projet projet;

  ProjetCv({Key key, this.projet}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    final newProjet = new Projet(null, null);
    final newLangue= new Langue(null,null);
    TextEditingController _titleController1 = new TextEditingController();
    TextEditingController _titleController2 = new TextEditingController();
    _titleController1.text = projet.title;

    return Scaffold(
        appBar: AppBar(
          title: Text('Projets Académiques'),
        ),
        endDrawer: drawer(),
        body: Center(
            child: SingleChildScrollView(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Saisir le titre de votre projet:"),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    controller: _titleController1,
                    autofocus: true,
                  ),
                ),
                Text("Saisir une description:"),

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
                        projet.title = _titleController1.text;
                        projet.descriptionP = _titleController2.text;
                        final FirebaseAuth _auth = FirebaseAuth.instance;
                        final FirebaseUser user = await _auth.currentUser();
                        final uid = user.uid;
                        await db.collection("userData")
                            .document(uid)
                            .collection("Cv")
                            .document(uid)
                            .collection("Projets Académiques")
                            .document("1").setData(projet.toJson());

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProjetCv(
                                  projet: newProjet,
                                )));
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30.0),

                RaisedButton(
                  child: Text("Enregistrer et passer au suivant"),
                  onPressed: () async {

                    projet.title = _titleController1.text;
                    projet.descriptionP = _titleController2.text;
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    final FirebaseUser user = await _auth.currentUser();
                    final uid = user.uid;
                    await db.collection("userData")
                        .document(uid)
                        .collection("Cv")
                        .document(uid)
                        .collection("Projets Académiques")
                        .document("2").setData(projet.toJson());

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LangueCv(langue: newLangue,))
                    );
                  },
                ),
                RaisedButton(
                  child: Text("Passer au suivant sans enregistrer"),
                  onPressed: () async {

                    projet.title = _titleController1.text;
                    projet.descriptionP = _titleController2.text;

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LangueCv(langue: newLangue,))
                    );
                  },
                ),
              ],
            )
        ))
    );
  }
}