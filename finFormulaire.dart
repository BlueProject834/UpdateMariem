import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cvmakerapp/screens/pageModelscv.dart';
import 'Forms/title.dart';
import 'classes/Titre.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'drawer.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'essai.dart';
import 'pdf.dart';

class pageFinFormulaire extends StatefulWidget {
  // ignore: camel_case_types

  pageFinFormulaire({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _pageFinFormulaireState createState() => _pageFinFormulaireState();
}

// ignore: camel_case_types
class _pageFinFormulaireState extends State<pageFinFormulaire> {

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
                                    PageModelsCv()));
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

  CvView(context) {

    String name = 'RHOUDRI ES-SAGHIR';

    pdf.addPage(p.MultiPage(
        pageFormat:
            PdfPageFormat.a4.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        crossAxisAlignment: p.CrossAxisAlignment.start,
        build: (p.Context context) => <p.Widget>[
              p.Container(
                color: PdfColors.black,
                padding: p.EdgeInsets.all(10.0),
                child: p.Row(
                    mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                    children: <p.Widget>[
                      p.Column(children: <p.Widget>[
                        p.Center(
                          child: p.Text(
                            '$name',
                            style: p.TextStyle(color: PdfColors.white),
                            textScaleFactor: 2,
                          ),
                        ),
                        p.Padding(padding: const p.EdgeInsets.all(20.0)),
                      ]),
                    ]
                ),
              ),
              p.Padding(padding: const p.EdgeInsets.all(10)),
              p.Container(
                // color: PdfColors.black,
                child: p.Column(
                  crossAxisAlignment: p.CrossAxisAlignment.start,
                  children: <p.Widget>[
                    p.Text(' Tel : 0604122034'),
                    p.Text(' Email : mariem.essghir@gmail.com'),
                    p.Text(' Adresse : Jet Sakan - Agadir'),
                    p.Text(' Permis : B'),
                  ],
                ),
              ),
              p.Container(
                height: 30.0,
              ),
              p.Header(
                  level: 1, child: p.Text('FORMATION', textScaleFactor: 2)),
              p.Container(
                child: p.Column(
                  children: <p.Widget>[
                    p.Wrap(
                      spacing: 40.0,
                      children: <p.Widget>[
                        p.Container(
                          //     color: PdfColors.grey,
                          width: 70.0,
                          height: 20.0,
                          child: p.Text('2016 - 2019'),
                        ),
                        p.Container(
                            //       color: PdfColors.grey,
                            width: 355.0,
                            child: p.Flexible(
                              child: p.Text(
                                  'Deug en science mathématique et informatique'),
                            )),
                      ],
                    ),
                    p.Padding(padding: const p.EdgeInsets.all(10)),
                    p.Wrap(
                      spacing: 40.0,
                      children: <p.Widget>[
                        p.Container(
                          //    color: PdfColors.grey,
                          width: 70.0,
                          height: 20.0,
                          child: p.Text('2018'),
                        ),
                        p.Container(
                            //      color: PdfColors.grey,
                            width: 355.0,
                            child: p.Flexible(
                              child: p.Text('Baccalaureat en Lettre'),
                            )),
                      ],
                    ),
                    p.Padding(padding: const p.EdgeInsets.all(10)),
                    p.Wrap(
                      spacing: 40.0,
                      children: <p.Widget>[
                        p.Container(
                          //    color: PdfColors.grey,
                          width: 70.0,
                          height: 20.0,
                          child: p.Text('2016 '),
                        ),
                        p.Container(
                            //      color: PdfColors.grey,
                            width: 355.0,
                            child: p.Flexible(
                              child: p.Text(
                                  'Baccalaureat en science mathematiques A'),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              p.Padding(padding: const p.EdgeInsets.all(10)),
              p.Header(
                  level: 1, child: p.Text('COMPETENCES', textScaleFactor: 2)),
              p.Column(
                crossAxisAlignment: p.CrossAxisAlignment.start,
                children: <p.Widget>[
                  p.Text(
                      ' Notions de base du developpement mobile avec  flutter'),
                  p.Text(' Notions de base du developpement web avec PHP'),
                  p.Text(' Notions de base en reseaux informatiques'),
                  p.Text(' Notions de base du developpement avec  flutter'),
                ],
              ),
              p.Padding(padding: const p.EdgeInsets.all(10)),
              p.Header(level: 1, child: p.Text('LANGUES', textScaleFactor: 2)),
              p.Column(
                crossAxisAlignment: p.CrossAxisAlignment.start,
                children: <p.Widget>[
                  p.Text(' Tamazight : langue maternelle'),
                  p.Text(' Arabe : courant'),
                  p.Text(' Francais : courant'),
                  p.Text(' Anglait : moyen'),
                ],
              ),
              p.Padding(padding: const p.EdgeInsets.all(10)),
              p.Header(
                  level: 1,
                  child: p.Text("CENTRES D'INTERET", textScaleFactor: 2)),
              p.Column(
                crossAxisAlignment: p.CrossAxisAlignment.start,
                children: <p.Widget>[
                  p.Text(' Travail associatif'),
                  p.Text(' Sport'),
                  p.Text(' Dessin'),
                  p.Text(' Peinture'),
                ],
              ),
            ]));
    //save PDF
  }
}
