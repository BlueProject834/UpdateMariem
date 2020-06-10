import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvmakerapp/classes/Competence.dart';
import 'package:cvmakerapp/classes/Formation.dart';
import 'package:cvmakerapp/Forms/formation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../drawer.dart';

class CompetenceCv extends StatelessWidget {

  final db = Firestore.instance;
  final Competence competence;

  CompetenceCv({Key key, this.competence}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    final newForm= new Formation(null,null,null,null,null);

    TextEditingController _titleController1 = new TextEditingController();
    TextEditingController _titleController2 = new TextEditingController();
    _titleController1.text = competence.title;

    final newComp = new Competence(_titleController1.text , _titleController2.text );

    return Scaffold(
        appBar: AppBar(
          title: Text('Compétences'),
        ),
        endDrawer: drawer(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Saisir vos compétences:"),
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
                        competence.title = _titleController1.text;
                        competence.descriptionC = _titleController2.text;
                        final FirebaseAuth _auth = FirebaseAuth.instance;
                        final FirebaseUser user = await _auth.currentUser();
                        final uid = user.uid;
                        await db.collection("userData")
                            .document(uid)
                            .collection("Cv")
                            .document(uid)
                            .collection("Compétences")
                            .document("1").setData(competence.toJson());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CompetenceCv(competence: newComp)));
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                RaisedButton(
                  child: Text("Enregistrer et passer au suivant"),
                  onPressed: () async {
                    competence.title = _titleController1.text;
                    competence.descriptionC = _titleController2.text;
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    final FirebaseUser user = await _auth.currentUser();
                    final uid = user.uid;
                    await db.collection("userData")
                        .document(uid)
                        .collection("Cv")
                        .document(uid)
                        .collection("Compétences")
                        .document("2").setData(competence.toJson());
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormationCv(formation: newForm))
                    );
                  },
                ),
                RaisedButton(
                  child: Text("Passer au suivant sans enregister"),
                  onPressed: () async {
                    competence.title = _titleController1.text;
                    competence.descriptionC = _titleController2.text;

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormationCv(formation: newForm))
                    );
                  },
                ),
              ],
            )
        )
        )
    );
  }
}