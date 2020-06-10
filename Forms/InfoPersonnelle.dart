import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvmakerapp/classes/Infos.dart';
import 'package:cvmakerapp/classes/Projet.dart';
import 'package:cvmakerapp/Forms/ProjetCv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InfoCv extends StatelessWidget {
  final db = Firestore.instance;

  final Infos info;

  InfoCv({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newProjet = new Projet(null, null);

    TextEditingController _titleController1 = new TextEditingController();
    TextEditingController _titleController2 = new TextEditingController();
    TextEditingController _titleController3 = new TextEditingController();
    TextEditingController _titleController4 = new TextEditingController();
    TextEditingController _titleController5 = new TextEditingController();
    TextEditingController _titleController6 = new TextEditingController();
    TextEditingController _titleController7 = new TextEditingController();
    TextEditingController _titleController8 = new TextEditingController();
    TextEditingController _titleController9 = new TextEditingController();
    TextEditingController _titleController10 = new TextEditingController();

    final newInfo = new Infos(
        _titleController1.text,
        _titleController2.text,
        _titleController3.text,
        _titleController4.text,
        _titleController5.text,
        _titleController6.text,
        _titleController7.text,
        _titleController8.text,
        _titleController9.text,
        _titleController10.text);

    return Scaffold(
        appBar: AppBar(
          title: Text('Infos Personnelles'),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Saisir votre nom:"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleController1,
                  autofocus: true,
                ),
              ),
              Text("Saisir votre prénom:"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleController2,
                  autofocus: true,
                ),
              ),
              Text("Numéro de téléphone:"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleController3,
                  autofocus: true,
                ),
              ),
              Text("Votre Adresse:"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleController4,
                  autofocus: true,
                ),
              ),
              Text("Code Postal:"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleController5,
                  autofocus: true,
                ),
              ),
              Text("Email:"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleController6,
                  autofocus: true,
                ),
              ),
              Text("Date de naissance:"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleController7,
                  autofocus: true,
                ),
              ),
              Text("Nationalité:"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleController8,
                  autofocus: true,
                ),
              ),
              Text("Etat Civil:"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleController9,
                  autofocus: true,
                ),
              ),
              Text("Permis:"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _titleController10,
                  autofocus: true,
                ),
              ),
              RaisedButton(
                child: Text("Suivant"),
                onPressed: () async {
                  info.nom = _titleController1.text;
                  info.prenom = _titleController2.text;
                  info.numtel = _titleController3.text;
                  info.adresse = _titleController4.text;
                  info.codepostal = _titleController5.text;
                  info.email = _titleController6.text;
                  info.datenaissance = _titleController7.text;
                  info.nationalite = _titleController8.text;
                  info.etatcivil = _titleController9.text;
                  info.permis = _titleController10.text;

                  final FirebaseAuth _auth = FirebaseAuth.instance;
                  final FirebaseUser user = await _auth.currentUser();
                  final uid = user.uid;
                  await db
                      .collection("userData")
                      .document(uid)
                      .collection("Cv")
                      .document(uid)
                      .collection("Infos Personnelles")
                      .document("1").setData(info.toJson());

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProjetCv(
                            projet: newProjet,
                              )));
                },
              ),
            ],
          ),
        )));
  }
}
