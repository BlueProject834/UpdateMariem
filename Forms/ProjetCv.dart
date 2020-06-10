import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvmakerapp/classes/Competence.dart';
import 'package:cvmakerapp/classes/Langue.dart';
import 'package:cvmakerapp/classes/Projet.dart';
import 'package:cvmakerapp/Forms/langue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProjetCv extends StatelessWidget {

  final db = Firestore.instance;
  final Projet projet;

  ProjetCv({Key key, this.projet}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    final newLangue= new Langue(null,null);
    TextEditingController _titleController1 = new TextEditingController();
    TextEditingController _titleController2 = new TextEditingController();
    _titleController1.text = projet.title;
    final newComp = new Competence(_titleController1.text , _titleController2.text );

    return Scaffold(
        appBar: AppBar(
          title: Text('Projets Académiques'),
        ),
        body: Center(
            child: Column(
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

                RaisedButton(
                  child: Text("Suivant"),
                  onPressed: () async {

                    projet.title = _titleController1.text;
                    projet.descriptionP = _titleController2.text;
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    final FirebaseUser user = await _auth.currentUser();
                    final uid = user.uid;
                    await db.collection("userData").document(uid).collection("Cv").document(uid).collection("Projets Académiques").add(projet.toJson());

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LangueCv(langue: newLangue,))
                    );
                  },
                ),
              ],
            )
        )
    );
  }
}