import 'package:flutter/cupertino.dart';
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
                  File file = File('$path/exemple.pdf');
                  //Write PDF data
                  await file.writeAsBytes(pdf.save(), flush: true);
                  //Open the PDF document in mobile
                  OpenFile.open('$path/exemple.pdf');

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
  dynamic dataTitre;
  dynamic dataLegende;
  dynamic dataProjet1;
  dynamic dataProjet2;
  dynamic dataExperience1;
  dynamic dataExperience2;


  Future<dynamic> getDataExperience2() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Experiences").document("2");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataExperience2 =snapshot.data;
      });
    });
  }
  Future<dynamic> getDataExperience1() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Experiences").document("1");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataExperience1 =snapshot.data;
      });
    });
  }
  Future<dynamic> getDataProjet2() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Projets Académiques").document("2");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataProjet2 =snapshot.data;
      });
    });
  }

  Future<dynamic> getDataProjet1() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Projets Académiques").document("1");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataProjet1 =snapshot.data;
      });
    });
  }

  Future<dynamic> getDataLegende() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Légende").document("1");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataLegende =snapshot.data;
      });
    });
  }

  Future<dynamic> getDataTitre() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    final DocumentReference document =
    Firestore.instance.collection("userData").document(uid).collection(
        "Cv").document(uid).collection("Titre").document("1");
    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        dataTitre =snapshot.data;
      });
    });
  }

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
    getDataTitre();
    getDataLegende();
    getDataProjet1();
    getDataProjet2();
    getDataExperience1();
    getDataExperience2();
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
                    color: PdfColors.blue,
                    child: p.Column(children: <p.Widget>[

                      p.Container(
                        height: 90.0,
                      ),

                      p.SizedBox(height: 20),
                      dataInfos!=null?
                      p.Container(
                        width: 100,
                        height: 60,
                      child: p.Center(
                        child: p.Text(
                          "${dataInfos['Prénom']!= null || dataInfos['Nom'] != null ? "${dataInfos['Prénom']} \n ${dataInfos['Nom']}" : "\n" }" ,
                          style: p.TextStyle(color: PdfColors.white),
                          textScaleFactor: 2,
                        ),
                      ),
                      ): p.Text(""),

                      p.Padding(padding: const p.EdgeInsets.only(top : 30.0)),

                      dataInfos!=null?
                      p.Container(
                        padding: p.EdgeInsets.only(left: 10.0),
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
                            p.Text('Nationnalité : ${dataInfos['Nationalité']}'): p.Text(' '),

                            dataInfos['Etat Civil'] != "" ?
                            p.Text('${dataInfos['Etat Civil']}'): p.Text(' '),

                            dataInfos['Permis'] != "" ?
                            p.Text('Permis : ${dataInfos['Permis']}'): p.Text(' '),

                          ],
                        ),
                      ):p.Text(""),

                      p.Padding(padding: const p.EdgeInsets.only(top : 30.0)),

                      dataLangue1 != null || dataLangue2 != null ?
                       p.Text('LANGUES',
                         style: p.TextStyle(
                           fontSize: 20.0,
                           color: PdfColors.indigo,
                         ),
                           //textScaleFactor: 2
                       ) : p.Text(""),

                      p.Padding(padding: const p.EdgeInsets.only(top : 15.0)),

                      dataLangue1 != null || dataLangue2 != null ?
                      p.Column(
                        crossAxisAlignment: p.CrossAxisAlignment.start,
                        children: <p.Widget>[
                          dataLangue1 != null ?
                          p.Text('${dataLangue1['Langue'] != "" ?  '${dataLangue1['Langue']}   : ${dataLangue1['Niveau']}' : "" }', textAlign: p.TextAlign.left,) : p.Text(""),
                          dataLangue2 != null ?
                          p.Text('${dataLangue2['Langue'] != "" ?  '${dataLangue2['Langue']}   : ${dataLangue2['Niveau']}' : "" }', textAlign: p.TextAlign.left,) : p.Text(""),
                        ],
                      ): p.Text(""),

                      p.Padding(padding: const p.EdgeInsets.only(top: 30)),

                      dataInteret1 != null || dataInteret2 != null ?
                       p.Text("CENTRES \nD'INTERET",
                           textAlign: p.TextAlign.center,
                         style: p.TextStyle(
                           fontSize: 20.0,
                           color: PdfColors.indigo,
                         ),
                         //  textScaleFactor: 2
                       )
                       : p.Text(""),

                      p.Padding(padding: const p.EdgeInsets.only(top: 15)),

                      dataInteret1 != null || dataInteret2 != null ?
                      p.Column(
                        crossAxisAlignment: p.CrossAxisAlignment.start,
                        children: <p.Widget>[
                          dataInteret1 != null ?
                          p.Text(' ${dataInteret1['Titre'] != "" ? "${dataInteret1['Titre']} \n   ${dataInteret1['Description']}" : "" }', textAlign: p.TextAlign.center,): p.Text(""),
                          dataInteret2 != null ?
                          p.Text(' ${ dataInteret2['Titre'] != "" ? "${dataInteret2['Titre']} \n   ${dataInteret2['Description']}" : "" }', textAlign: p.TextAlign.center,): p.Text(""),
                        ],
                      ): p.Text(""),


                    ]),
                  ),
                ]
              ),


              p.Column(
                 children: <p.Widget>[
                   p.Container(
                     width: 300,
                     height: 700,
                    color: PdfColors.blue,
                       child: p.Column(
                       children: <p.Widget>[
                        p.SizedBox( height: 3.0),
                       p.Container(
                         padding: p.EdgeInsets.only(right: 3.0,left: 0.0),
                           width: 295,
                           height: 695,
                            color: PdfColors.white,
                          child: p.Column(
                            children: <p.Widget>[
                              p.Padding(padding: const p.EdgeInsets.only(top: 25)),
                              dataTitre!=null?
                              p.Text(
                                    "${dataTitre['title']}" ,
                                    style: p.TextStyle(color: PdfColors.blue),
                                    textScaleFactor: 2,

                              ): p.Text(""),

                              p.Padding(padding: const p.EdgeInsets.only(top: 20)),

                              dataLegende!=null?
                              p.Flexible(
                              child:
                              p.Text(
                                    "${dataLegende['Legende']}" ,
                                    style: p.TextStyle(color: PdfColors.black),
                                    textScaleFactor: 1,
                                  ) ,
                               ): p.Text(""),


                              p.Padding(padding: const p.EdgeInsets.all(10)),
                              dataExperience1 != null || dataExperience2 != null ?
                              p.Text("EXPERIENCES",
                                style: p.TextStyle(
                                  fontSize: 20.0,
                                  color: PdfColors.indigo,
                                ),
                                 // textScaleFactor: 2
                              ): p.Text(""),

                              dataExperience1 != null || dataExperience2 != null ?
                              p.Container(
                                child: p.Column(
                                  children: <p.Widget>[
                                    dataExperience1 != null ?
                                    p.Column(
                                      children: <p.Widget>[

                                        p.Text(' ${dataExperience1['Année fin']!="" && dataExperience1['Année du début']!=""? " ${dataExperience1['Année du début']} - ${dataExperience1['Année fin']} ": "${dataExperience1['Année du début']}  ${dataExperience1['Année fin']}"}'),
                                        p.Padding(padding: const p.EdgeInsets.all(5)),
                                        p.Text(
                                            "${dataExperience1['Titre'] != "" ? dataExperience1['Titre']: ""}", textAlign: p.TextAlign.center,),
                                        p.Text(
                                            "${dataExperience1['Institut'] != "" ? dataExperience1['Institut']: ""}", textAlign: p.TextAlign.center,),

                                        //    ])),
                                      ],
                                    ): p.Text(""),
                                    p.Padding(padding: const p.EdgeInsets.all(10)),
                                    dataExperience2 != null ?
                                    p.Column(
                                      children: <p.Widget>[

                                        p.Text(' ${dataExperience2['Année fin']!="" && dataExperience2['Année du début']!=""? "${dataExperience2['Année du début']} - ${dataExperience2['Année fin']} ": "${dataExperience2['Année du début']}  ${dataExperience2['Année fin']}"}'),
                                        p.Padding(padding: const p.EdgeInsets.all(5)),
                                        p.Text(
                                            "${dataExperience2['Titre'] != "" ? dataExperience2['Titre']: ""}", textAlign: p.TextAlign.center,),
                                        p.Text(
                                            "${dataExperience2['Institut'] != "" ? dataExperience2['Institut']: ""}", textAlign: p.TextAlign.center,),

                                      ],
                                    ) : p.Text( ' '),

                                  ],
                                ),
                              ): p.Text(' '),

                              p.Padding(padding: const p.EdgeInsets.all(10)),

                              dataFormation != null || dataFormation2 != null ?
                              p.Text("FORMATION",
                                style: p.TextStyle(
                                  fontSize: 20.0,
                                  color: PdfColors.indigo,
                                ),
                                  //textScaleFactor: 2
                                 ): p.Text(""),

                              p.Padding(padding: const p.EdgeInsets.all(5)),

                              dataFormation != null || dataFormation2 != null ?
                              p.Container(
                                child: p.Column(
                                  children: <p.Widget>[
                                    dataFormation != null ?
                                    p.Column(
                                      children: <p.Widget>[

                                                  p.Text(' ${dataFormation['Année fin']!="" && dataFormation['Année du début']!=""? " ${dataFormation['Année du début']} - ${dataFormation['Année fin']} ": "${dataFormation['Année du début']}  ${dataFormation['Année fin']}"}'),
                                                   p.Padding(padding: const p.EdgeInsets.all(5)),
                                                  p.Text(
                                                      "${dataFormation['Diplôme'] != "" ? dataFormation['Diplôme']: ""}"),
                                                  p.Text(
                                                      "${dataFormation['Institut'] != "" ? dataFormation['Institut']: ""}"),
                                                  p.Text(
                                                      "${dataFormation['Description'] != "" ? dataFormation['Description']: ""}"),

                                            //    ])),
                                      ],
                                    ): p.Text(""),
                                    p.Padding(padding: const p.EdgeInsets.all(10)),
                                    dataFormation2 != null ?
                                    p.Column(
                                      children: <p.Widget>[

                                                  p.Text(' ${dataFormation2['Année fin']!="" && dataFormation2['Année du début']!=""? "${dataFormation2['Année du début']} - ${dataFormation2['Année fin']} ": "${dataFormation2['Année du début']}  ${dataFormation2['Année fin']}"}'),
                                                 p.Padding(padding: const p.EdgeInsets.all(5)),
                                                  p.Text(
                                                      "${dataFormation2['Diplôme'] != "" ? dataFormation2['Diplôme']: ""}", textAlign: p.TextAlign.center,),
                                                  p.Text(
                                                      "${dataFormation2['Institut'] != "" ? dataFormation2['Institut']: ""}", textAlign: p.TextAlign.center,),
                                                  p.Text(
                                                      "${dataFormation2['Description'] != "" ? dataFormation2['Description']: ""}", textAlign: p.TextAlign.center,),

                                      ],
                                    ) : p.Text( ' '),

                                  ],
                                ),
                              ): p.Text(' '),
                              p.Padding(padding: const p.EdgeInsets.all(10)),


                              dataProjet1 != null || dataProjet2 != null ?
                              p.Text("PROJETS ACADEMIQUES", textAlign: p.TextAlign.center,
                                  style: p.TextStyle(
                                    fontSize: 20.0,
                                    color: PdfColors.indigo,
                                  ),
                                 // textScaleFactor: 1.2
                              ): p.Text(""),
                              p.Padding(padding: const p.EdgeInsets.all(5)),

                              dataProjet1 != null || dataProjet2 != null ?
                              p.Container(
                                child: p.Column(
                                  children: <p.Widget>[
                                    dataProjet1 != null ?
                                    p.Column(
                                      children: <p.Widget>[
                                        p.Text(
                                            "${dataProjet1['Titre'] != "" ? dataProjet1['Titre']: ""}", textAlign: p.TextAlign.center,),
                                        p.Text(
                                            "${dataProjet1['Description'] != "" ? dataProjet1['Description']: ""}", textAlign: p.TextAlign.center,),

                                        //    ])),
                                      ],
                                    ): p.Text(""),
                                    p.Padding(padding: const p.EdgeInsets.all(10)),
                                    dataProjet2 != null ?
                                    p.Column(
                                      children: <p.Widget>[
                                        p.Text(
                                            "${dataProjet2['Titre'] != "" ? dataProjet2['Titre']: ""}", textAlign: p.TextAlign.center,),
                                        p.Text(
                                            "${dataProjet2['Description'] != "" ? dataProjet2['Description']: ""}", textAlign: p.TextAlign.center,),

                                      ],
                                    ) : p.Text( ' '),
                                  ],
                                ),
                              ): p.Text(' '),
                              p.Padding(padding: const p.EdgeInsets.all(10)),
                              dataCompetence1 != null || dataCompetence2 != null ?
                              p.Text("COMPETENCES",
                                  style: p.TextStyle(
                                    fontSize: 20.0,
                                    color: PdfColors.indigo,
                                  ),
                                  textAlign: p.TextAlign.center,
                                  //textScaleFactor: 2
                                ): p.Text(""),
                              p.Padding(padding: const p.EdgeInsets.all(5)),

                              dataCompetence1 != null || dataCompetence2 != null ?
                              p.Container(
                                child: p.Column(
                                  children: <p.Widget>[
                                    dataCompetence1 != null ?
                                    p.Column(
                                      children: <p.Widget>[
                                        p.Text(
                                          "${dataCompetence1['Titre'] != "" ? dataCompetence1['Titre']: ""}", textAlign: p.TextAlign.center,),
                                        p.Text(
                                          "${dataCompetence1['Description'] != "" ? dataCompetence1['Description']: ""}", textAlign: p.TextAlign.center,),

                                        //    ])),
                                      ],
                                    ): p.Text(""),
                                    p.Padding(padding: const p.EdgeInsets.all(10)),
                                    dataCompetence2 != null ?
                                    p.Column(
                                      children: <p.Widget>[
                                        p.Text(
                                          "${dataCompetence2['Titre'] != "" ? dataCompetence2['Titre']: ""}", textAlign: p.TextAlign.center,),
                                        p.Text(
                                          "${dataCompetence2['Description'] != "" ? dataCompetence2['Description']: ""}", textAlign: p.TextAlign.center,),

                                      ],
                                    ) : p.Text( ' '),
                                  ],
                                ),
                              ): p.Text(' '),


                         ],
                          ),
                   ),
                      //   p.SizedBox( height: 3.0),

                     ],
                   ),
                   ),
                 ],
              ),


            ],
          ),

        ],
      ),
    );
  }
}
