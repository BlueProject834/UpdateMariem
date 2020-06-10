import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvmakerapp/classes/Experience.dart';
import 'package:cvmakerapp/classes/Formation.dart';
import 'package:cvmakerapp/Forms/CentreInteret.dart';
import 'package:cvmakerapp/Forms/Competence.dart';
import 'package:cvmakerapp/Forms/ExperienceCv.dart';
import 'package:cvmakerapp/Forms/formation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../drawer.dart';



class FormationCv extends StatelessWidget {

  final db = Firestore.instance;

  final Formation formation;

  FormationCv({Key key, this.formation}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    final newExp= new Experience(null,null,null,null);
    TextEditingController _titleController1 = new TextEditingController();
    TextEditingController _titleController2 = new TextEditingController();
    TextEditingController _titleController3 = new TextEditingController();
    TextEditingController _titleController4 = new TextEditingController();
    TextEditingController _titleController5 = new TextEditingController();

    final newForm = new Formation(_titleController1.text , _titleController2.text ,  _titleController3.text , _titleController4.text ,  _titleController5.text  );
    return Scaffold(
        appBar: AppBar(
          title: Text('Formations'),
        ),
        endDrawer: drawer(),
        body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Entrer la date du début de formation:"),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextField(
                      controller: _titleController1,
                      autofocus: true,
                    ),
                  ),
                  Text("Entrer la date fin de formation:"),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextField(
                      controller: _titleController2,
                      autofocus: true,
                    ),
                  ),
                  Text("Diplôme:"),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextField(
                      controller: _titleController3,
                      autofocus: true,
                    ),
                  ),
                  Text("Nom de l'institut:"),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextField(
                      controller: _titleController4,
                      autofocus: true,
                    ),
                  ),
                  Text("Description:"),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextField(
                      controller: _titleController5,
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
                          formation.anneeDebF = _titleController1.text;
                          formation.anneeFinF = _titleController2.text;
                          formation.diplome = _titleController3.text;
                          formation.institut = _titleController4.text;
                          formation.descriptionF = _titleController5.text;
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          final FirebaseUser user = await _auth.currentUser();
                          final uid = user.uid;
                          await db.collection("userData")
                              .document(uid)
                              .collection("Cv")
                              .document(uid)
                              .collection("Formations")
                              .document("1").setData(formation.toJson());
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FormationCv(formation: newForm))
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  RaisedButton(
                    child: Text("Enregistrer et passer au suivant"),
                    onPressed: () async {
                      formation.anneeDebF = _titleController1.text;
                      formation.anneeFinF = _titleController2.text;
                      formation.diplome = _titleController3.text;
                      formation.institut = _titleController4.text;
                      formation.descriptionF = _titleController5.text;
                      final FirebaseAuth _auth = FirebaseAuth.instance;
                      final FirebaseUser user = await _auth.currentUser();
                      final uid = user.uid;
                      await db.collection("userData")
                          .document(uid)
                          .collection("Cv")
                          .document(uid)
                          .collection("Formations")
                          .document("2").setData(formation.toJson());
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ExperienceCv(experience: newExp,))
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text("Passer au suivant sans enregistrer"),
                    onPressed: () async {
                      formation.anneeDebF = _titleController1.text;
                      formation.anneeFinF = _titleController2.text;
                      formation.diplome = _titleController3.text;
                      formation.institut = _titleController4.text;
                      formation.descriptionF = _titleController5.text;

                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ExperienceCv(experience: newExp,))
                      );
                    },
                  ),
                ],
              ),
            )
        )
    );
  }
}