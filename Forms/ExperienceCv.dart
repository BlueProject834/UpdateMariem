import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvmakerapp/classes/Experience.dart';
import 'package:cvmakerapp/classes/Infos.dart';
import 'package:cvmakerapp/Forms/InfoPersonnelle.dart';
import 'package:cvmakerapp/Forms/formation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExperienceCv extends StatelessWidget {

  final db = Firestore.instance;

  final Experience experience;

  ExperienceCv({Key key, this.experience}) : super(key: key);

  @override

  Widget build(BuildContext context) {

    final newInfo= new Infos(null,null,null,null,null,null,null,null,null,null);

    TextEditingController _titleController1 = new TextEditingController();

    TextEditingController _titleController2 = new TextEditingController();

    TextEditingController _titleController3 = new TextEditingController();

    TextEditingController _titleController4 = new TextEditingController();



    final newExp = new Experience(_titleController1.text , _titleController2.text ,  _titleController3.text , _titleController4.text );

    return Scaffold(

        appBar: AppBar(

          title: Text('Expériences'),

        ),

        body: Center(

            child: SingleChildScrollView(

              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  Text("Entrer la date du début de l'expérience:"),

                  Padding(

                    padding: const EdgeInsets.all(30.0),

                    child: TextField(

                      controller: _titleController1,

                      autofocus: true,

                    ),

                  ),

                  Text("Entrer la date fin de l'expérience:"),

                  Padding(

                    padding: const EdgeInsets.all(30.0),

                    child: TextField(

                      controller: _titleController2,

                      autofocus: true,

                    ),

                  ),

                  Text("Titre d'expérience:"),

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



                  RaisedButton(

                    child: Text("Suivant"),

                    onPressed: () async {

                      experience.anneeDebE = _titleController1.text;

                      experience.anneeFinE = _titleController2.text;

                      experience.titreE = _titleController3.text;

                      experience.institut = _titleController4.text;

                      final FirebaseAuth _auth = FirebaseAuth.instance;

                      final FirebaseUser user = await _auth.currentUser();

                      final uid = user.uid;

                      await db.collection("userData").document(uid).collection("Cv").document(uid).collection("Experiences").add(experience.toJson());

                      Navigator.push(

                          context,

                          MaterialPageRoute(builder: (context) => InfoCv(info: newInfo))

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