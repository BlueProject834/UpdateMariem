import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvmakerapp/classes/Competence.dart';
import 'package:cvmakerapp/classes/Interet.dart';
import 'package:cvmakerapp/Forms/Competence.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CentreInteretCv extends StatelessWidget {

  final db = Firestore.instance;
  final Interet interet;

  CentreInteretCv({Key key, this.interet}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    final newComp= new Competence(null,null);

    TextEditingController _titleController1 = new TextEditingController();

    TextEditingController _titleController2 = new TextEditingController();

    final newInteret = new Interet(_titleController1.text , _titleController2.text );

    return Scaffold(

        appBar: AppBar(

          title: Text("Centre d'intérêts "),

        ),

        body: Center(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[

                Text("Saisir votre centre d'intérêt:"),

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

                    interet.title = _titleController1.text;

                    interet.descriptionI = _titleController2.text;

                    final FirebaseAuth _auth = FirebaseAuth.instance;

                    final FirebaseUser user = await _auth.currentUser();

                    final uid = user.uid;

                    await db.collection("userData").document(uid).collection("Cv").document(uid).collection("Centre Interet").add(interet.toJson());

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CompetenceCv(competence: newComp))

                    );

                  },

                ),

              ],

            )

        )

    );

  }

}