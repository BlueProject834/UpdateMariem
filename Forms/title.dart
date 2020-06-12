import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvmakerapp/classes/Legend.dart';
import 'package:cvmakerapp/classes/Titre.dart';
import 'package:cvmakerapp/Forms/legend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../drawer.dart';
import '../finFormulaire.dart';


class TitreCv extends StatelessWidget {
  final db = Firestore.instance;
  final Titre titre;
  TitreCv({Key key, @required this.titre}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final newLegend = new Legend(null);
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = titre.title;
    final newTitle = new Titre(_titleController.text);

    return Scaffold(
        appBar: AppBar(
          title: Text('Titre Cv'),
        ),
        endDrawer: drawer(),
        body: Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Entrer un titre pour votre cv"),
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: TextField(
                    controller: _titleController,
                    autofocus: true,
                  ),
                ),

                RaisedButton(
                  child: Text("Enregistrer et passer au suivant"),
                  onPressed: () async {
                    titre.title = _titleController.text;
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    final FirebaseUser user = await _auth.currentUser();
                    final uid = user.uid;

                 //   await db.collection("userData").document(uid).collection("Cv").document(uid).collection("Titre").add(titre.toJson());

                    await db.collection("userData").document(uid).collection(
                        "Cv").document(uid).collection("Titre").document("1").setData(
                        titre.toJson());

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LegendCv(legend: newLegend))
                    );
                  },
                ),

                RaisedButton(
                  child: Text("Passer au suivant sans enregistrer"),
                  onPressed: () async {
                    titre.title = _titleController.text;

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LegendCv(legend: newLegend))
                    );
                  },
                ),

              ],
            )
        )
    );
  }
}