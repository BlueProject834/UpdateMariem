import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:cvmakerapp/screens/pageModelscv.dart';
import 'Forms/title.dart';
import 'classes/Titre.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'drawer.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'PageModeleCv2.dart';
import 'pdf.dart';

class pageFinFormulaire2 extends StatefulWidget {
  // ignore: camel_case_types

  pageFinFormulaire2({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _pageFinFormulaire2State createState() => _pageFinFormulaire2State();
}

// ignore: camel_case_types
class _pageFinFormulaire2State extends State<pageFinFormulaire2> {

  final newTitle = new Titre(null);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cv Maker',
        ),
      ),
      endDrawer: drawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top:10.0, left: 10.0),
            color: Colors.white,
            child: new ListTile(
                leading: Icon(
                  Icons.remove_red_eye,
                  color: Colors.indigoAccent,
                ),
                title: new Text(
                  "Voir",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "PlayfairDisplay",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  'Voir le CV et verifier les donnees saisies',
                  style: TextStyle(
                    color: Colors.indigoAccent,
                    fontSize: 14,
                  ),
                ),
                onTap: () async {
                  CvView(context);
                  final String dir =
                      (await getApplicationDocumentsDirectory()).path;
                  final String path = '$dir/report.pdf';
                  final File file = File(path);
                  await file.writeAsBytes(pdf.save());
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PdfPreview(path: path),
                    ),
                  );

                  //  Navigator.of(context).push(new MaterialPageRoute(
                  //      builder: (BuildContext context) => firstModel()));
                }),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            color: Colors.white,
            child: new ListTile(
                leading: Icon(Icons.edit, color: Colors.blue),
                title: new Text(
                  "Editer ",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "PlayfairDisplay",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  'Changer le modele ou les donnees du CV',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  return Alert(
                      context: context,
                      title: "Choisir ce que vous voulez editer",
                      buttons: [
                        DialogButton(
                          child: Text('Le modele'),
                          color: Hexcolor('#774781'),
                          onPressed: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PageModelsCv2()));
                          },
                        ),
                        DialogButton(
                          child: Text('Les donnees'),
                          color: Hexcolor('#774781'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TitreCv(titre: newTitle)));
                          },
                        ),
                      ]).show();
                }),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            color: Colors.white,
            child: new ListTile(
                leading: Icon(Icons.save, color: Colors.cyan),
                title: new Text(
                  "Exporter",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "PlayfairDisplay",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  'Enregistrer le CV dans votre telephone',
                  style: TextStyle(color: Colors.cyan),
                ),
                onTap: () async {
                  CvView(context);
                  Directory directory = await getExternalStorageDirectory();
                  //Get directory path
                  String path = directory.path;
                  //Create an empty file to write PDF data
                  File file = File('$path/Output.pdf');
                  //Write PDF data
                  await file.writeAsBytes(pdf.save(), flush: true);
                  //Open the PDF document in mobile
                  OpenFile.open('$path/Output.pdf');

                  //  Navigator.of(context).push(new MaterialPageRoute(
                  //      builder: (BuildContext context) => firstModel()));
                }),
          ),
        ],
      ),
    );
  }

  final p.Document pdf = p.Document();


  dynamic dataInfos;
  dynamic dataFormation;
  dynamic dataFormation2;
  dynamic dataCompetence1;
  dynamic dataCompetence2;
  dynamic dataLangue1;
  dynamic dataLangue2;
  dynamic dataInteret1;
  dynamic dataInteret2;

  Future<dynamic> getDataInfos() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Infos Personnelles").document("1");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataInfos =snapshot.data;
      });
    });
  }

  Future<dynamic> getDataFormation() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Formations").document("1");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataFormation =snapshot.data;
      });
    });
  }

  Future<dynamic> getDataFormation2() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Formations").document("2");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataFormation2=snapshot.data;
      });
    });
  }

  Future<dynamic> getDataComp1() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Compétences").document("1");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataCompetence1 =snapshot.data;
      });
    });
  }
  Future<dynamic> getDataComp2() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Compétences").document("2");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataCompetence2 =snapshot.data;
      });
    });
  }

  Future<dynamic> getDataLangue1() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Langues").document("1");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataLangue1 =snapshot.data;
      });
    });
  }

  Future<dynamic> getDataLangue2() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Langues").document("2");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataLangue2 =snapshot.data;
      });
    });
  }

  Future<dynamic> getDataInteret1() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Centre Interet").document("1");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataInteret1 =snapshot.data;
      });
    });
  }

  Future<dynamic> getDataInteret2() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Centre Interet").document("2");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataInteret2 =snapshot.data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataInfos();
    getDataFormation();
    getDataFormation2();
    getDataComp1();
    getDataComp2();
    getDataLangue1();
    getDataLangue1();
    getDataLangue2();
    getDataInteret1();
    getDataInteret2();
  }


  CvView(context) {

    pdf.addPage(p.MultiPage(
        pageFormat:
        PdfPageFormat.a4.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        crossAxisAlignment: p.CrossAxisAlignment.start,
        build: (p.Context context) => <p.Widget>[

          p.Wrap(
            children: <p.Widget>[
              p.Column(
                children: <p.Widget>[
                  p.Container(
                    width: 160,
                    height: 700,
                    color: PdfColors.teal,
                    child: p.Column(children: <p.Widget>[
                      p.Center(
                        child: p.Text(
                          "${dataInfos['Prénom']!= null || dataInfos['Nom'] != null ? "${dataInfos['Prénom']} \n ${dataInfos['Nom']}" : "\n" }" ,
                          style: p.TextStyle(color: PdfColors.white),
                          textScaleFactor: 2,
                        ),
                      ),
                      p.Padding(padding: const p.EdgeInsets.all(20.0)),
                    ]),
                  ),
                ]
              ),
              p.Column(
                 children: <p.Widget>[
                   p.Container(
                      width: 300,
                     height: 700,
                    color: PdfColors.getColor("index")
                   ),
                 ],
              ),
            ],
          ),



/*
          // on teste s'il existe des infos personnelles
          dataInfos!=null?
          p.Container(
            color: PdfColors.red,
            padding: p.EdgeInsets.all(10.0),
            child: p.Row(
                mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                children: <p.Widget>[
                  p.Column(children: <p.Widget>[
                    p.Center(
                      child: p.Text(
                        "${dataInfos['Prénom']!= null || dataInfos['Nom'] != null ? "${dataInfos['Prénom']} \n ${dataInfos['Nom']}" : "\n" }" ,
                        style: p.TextStyle(color: PdfColors.white),
                        textScaleFactor: 2,
                      ),
                    ),
                    p.Padding(padding: const p.EdgeInsets.all(20.0)),
                  ]),
                ]
            ),
          )
          // Sinon
              : p.Text(''),
          p.Padding(padding: const p.EdgeInsets.all(10)),

          dataInfos!=null?
          p.Container(
            // color: PdfColors.black,
            child: p.Column(
              crossAxisAlignment: p.CrossAxisAlignment.start,
              children: <p.Widget>[

                dataInfos['Num Tél'] != "" ?
                p.Text('Tel : ${dataInfos['Num Tél']}') : p.Text(' '),

                dataInfos['Email'] != "" ?
                p.Text('Email : ${dataInfos['Email']}'): p.Text(' '),

                dataInfos['Adresse'] != "" ?
                p.Text('Adresse : ${dataInfos['Code Postal']}, ${dataInfos['Adresse']}'): p.Text(' '),

                dataInfos['Nationalité'] != "" ?
                p.Text('${dataInfos['Nationalité']}'): p.Text(' '),

                dataInfos['Etat Civil'] != "" ?
                p.Text('${dataInfos['Etat Civil']}'): p.Text(' '),

                dataInfos['Permis'] != "" ?
                p.Text('Permis : ${dataInfos['Permis']}'): p.Text(' '),

              ],
            ),
          ):p.Text(""),
          p.Container(
            height: 30.0,
          ),
          dataFormation != null || dataFormation2 != null ?
          p.Header(
              level: 1, child: p.Text("FORMATION", textScaleFactor: 2)): p.Text(""),
          dataFormation != null || dataFormation2 != null ?
          p.Container(
            child: p.Column(
              children: <p.Widget>[
                dataFormation != null ?
                p.Wrap(
                  spacing: 40.0,
                  children: <p.Widget>[
                    p.Container(
                      //     color: PdfColors.grey,
                      width: 70.0,
                      height: 20.0,
                      child: p.Text(' ${dataFormation['Année fin']!="" && dataFormation['Année du début']!=""? "${dataFormation['Année du début']} - ${dataFormation['Année fin']} ": "${dataFormation['Année du début']}  ${dataFormation['Année fin']}"}'),
                    ),
                    p.Container(
                      //       color: PdfColors.grey,
                        width: 355.0,
                        child: p.Column(
                            children: [
                              p.Text(
                                  "${dataFormation['Diplôme'] != "" ? dataFormation['Diplôme']: ""}"),
                              p.Text(
                                  "${dataFormation['Institut'] != "" ? dataFormation['Institut']: ""}"),
                              p.Text(
                                  "${dataFormation['Description'] != "" ? dataFormation['Description']: ""}"),

                            ])),
                  ],
                ): p.Text(""),
                p.Padding(padding: const p.EdgeInsets.all(10)),
                dataFormation2 != null ?
                p.Wrap(
                  spacing: 40.0,
                  children: <p.Widget>[
                    p.Container(
                      //     color: PdfColors.grey,
                      width: 70.0,
                      height: 20.0,
                      child: p.Text(' ${dataFormation2['Année fin']!="" && dataFormation2['Année du début']!=""? "${dataFormation2['Année du début']} - ${dataFormation2['Année fin']} ": "${dataFormation2['Année du début']}  ${dataFormation2['Année fin']}"}'),
                    ),
                    p.Container(
                      //       color: PdfColors.grey,
                        width: 355.0,
                        child: p.Column(
                            children: [
                              p.Text(
                                  "${dataFormation2['Diplôme'] != "" ? dataFormation2['Diplôme']: ""}"),
                              p.Text(
                                  "${dataFormation2['Institut'] != "" ? dataFormation2['Institut']: ""}"),
                              p.Text(
                                  "${dataFormation2['Description'] != "" ? dataFormation2['Description']: ""}"),

                            ]
                        )
                    ),
                  ],
                ) : p.Text( ' '),
                p.Padding(padding: const p.EdgeInsets.all(10)),
              ],
            ),
          ): p.Text(' '),
          p.Padding(padding: const p.EdgeInsets.all(10)),

          dataCompetence1 != null || dataCompetence2 != null  ?
          p.Header(
              level: 1, child: p.Text('COMPETENCES', textScaleFactor: 2)
          ): p.Text(""),
          dataCompetence1 != null || dataCompetence2 != null  ?
          p.Column(
            crossAxisAlignment: p.CrossAxisAlignment.start,
            children: <p.Widget>[
              dataCompetence1 != null ?
              p.Text(
                  "${dataCompetence1['Titre']!="" ? '${dataCompetence1['Titre']} \n  ${dataCompetence1['Description']}' :"" }"): p.Text(""),
              dataCompetence1 != null ?
              p.Text(
                  "${dataCompetence2['Titre']!="" ? '${dataCompetence2['Titre']} \n  ${dataCompetence2['Description']}' :"" }"): p.Text(""),
            ],
          ): p.Text(""),

          p.Padding(padding: const p.EdgeInsets.all(10)),

          dataLangue1 != null || dataLangue2 != null ?
          p.Header(level: 1, child: p.Text('LANGUES', textScaleFactor: 2)
          ): p.Text(""),

          dataLangue1 != null || dataLangue2 != null ?
          p.Column(
            crossAxisAlignment: p.CrossAxisAlignment.start,
            children: <p.Widget>[
              dataLangue1 != null ?
              p.Text('${dataLangue1['Langue'] != "" ?  '${dataLangue1['Langue']}   : ${dataLangue1['Niveau']}' : "" }') : p.Text(""),
              dataLangue2 != null ?
              p.Text('${dataLangue2['Langue'] != "" ?  '${dataLangue2['Langue']}   : ${dataLangue2['Niveau']}' : "" }') : p.Text(""),
            ],
          ): p.Text(""),

          p.Padding(padding: const p.EdgeInsets.all(10)),

          dataInteret1 != null || dataInteret2 != null ?
          p.Header(
              level: 1,
              child: p.Text("CENTRES D'INTERET", textScaleFactor: 2)): p.Text(""),
          dataInteret1 != null || dataInteret2 != null ?
          p.Column(
            crossAxisAlignment: p.CrossAxisAlignment.start,
            children: <p.Widget>[
              dataInteret1 != null ?
              p.Text(' ${dataInteret1['Titre'] != "" ? "${dataInteret1['Titre']} \n   ${dataInteret1['Description']}" : "" }'): p.Text(""),
              dataInteret2 != null ?
              p.Text(' ${ dataInteret2['Titre'] != "" ? "${dataInteret2['Titre']} \n   ${dataInteret2['Description']}" : "" }'): p.Text(""),
            ],
          ): p.Text(""),
       */

        ],
      ),
    );
  }
}
