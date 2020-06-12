import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' as mtr;
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'pdf.dart';

class firstModel extends mtr.StatefulWidget {
  firstModel({mtr.Key key, this.title}) : super(key: key);
  final String title;

  @override
  _firstModelState createState() => _firstModelState();
}

class _firstModelState extends mtr.State<firstModel> {
  @override
  mtr.Widget build(mtr.BuildContext context) {
    // TODO: implement build
    return mtr.Scaffold(
      appBar: mtr.AppBar(
        centerTitle: true,
        title: mtr.Text(
          "Modèles de CV",
          style: mtr.TextStyle(
            color: mtr.Colors.black,
            fontFamily: "PlayfairDisplay",
            fontSize: 20,
            fontWeight: mtr.FontWeight.w700,
          ),
        ),
      ),
      body: mtr.StreamBuilder(
          stream: Firestore.instance.collection('modele').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const mtr.Text("Chargement en cours des donnees...");
            } else {
              return mtr.RaisedButton(onPressed: () async {
                CvView(context);
                final String dir =
                    (await getApplicationDocumentsDirectory()).path;
                final String path = '$dir/report.pdf';
                final File file = File(path);
                await file.writeAsBytes(pdf.save());
                mtr.Navigator.of(context).pop();
                mtr.Navigator.of(context).push(
                  mtr.MaterialPageRoute(
                    builder: (_) => PdfPreview(path: path),
                  ),
                );
              });
            }
          }),
    );
  }

  final Document pdf = Document();

  CvView(context) {
    String name = 'ES-SAGHIR MARIEM';

    pdf.addPage(MultiPage(
        pageFormat:
            PdfPageFormat.a4.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        crossAxisAlignment: CrossAxisAlignment.start,

        build: (Context context) => <Widget>[
              Container(
                color: PdfColors.black,
                padding: EdgeInsets.all(10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(children: <Widget>[
                        Center(
                          child: Text(
                            '$name',
                            style: TextStyle(color: PdfColors.white),
                            textScaleFactor: 2,
                          ),
                        ),
                        Padding(padding: const EdgeInsets.all(20.0)),
                      ]),
                    ]),
              ),
              Padding(padding: const EdgeInsets.all(10)),
              Container(
                // color: PdfColors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(' Tel : 0604122034'),
                    Text(' Email : mariem.essghir@gmail.com'),
                    Text(' Adresse : Jet Sakan - Agadir'),
                    Text(' Permis : B'),
                  ],
                ),
              ),
              Container(
                height: 30.0,
              ),
              Header(level: 1, child: Text('FORMATION', textScaleFactor: 2)),
              Container(
                child: Column(
                  children: <Widget>[
                    Wrap(
                      spacing: 40.0,
                      children: <Widget>[
                        Container(
                          //     color: PdfColors.grey,
                          width: 70.0,
                          height: 20.0,
                          child: Text('2016 - 2019'),
                        ),
                        Container(
                            //       color: PdfColors.grey,
                            width: 355.0,
                            child: Flexible(
                              child: Text(
                                  'Deug en science mathématique et informatique'),
                            )),
                      ],
                    ),

                    Padding(padding: const EdgeInsets.all(10)),
                    Wrap(
                      spacing: 40.0,
                      children: <Widget>[
                        Container(
                          //    color: PdfColors.grey,
                          width: 70.0,
                          height: 20.0,
                          child: Text('2018'),
                        ),
                        Container(
                          //      color: PdfColors.grey,
                            width: 355.0,
                            child: Flexible(
                              child: Text(
                                  'Baccalaureat en Lettre'),
                            )),
                      ],
                    ),

                    Padding(padding: const EdgeInsets.all(10)),
                    Wrap(
                      spacing: 40.0,
                      children: <Widget>[
                        Container(
                          //    color: PdfColors.grey,
                          width: 70.0,
                          height: 20.0,
                          child: Text('2016 '),
                        ),
                        Container(
                            //      color: PdfColors.grey,
                            width: 355.0,
                            child: Flexible(
                              child: Text(
                                  'Baccalaureat en science mathematiques A'),
                            )),
                      ],
                    ),

                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.all(10)),
              Header(level: 1, child: Text('COMPETENCES', textScaleFactor: 2)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(' Notions de base du developpement mobile avec  flutter'),
              Text(' Notions de base du developpement web avec PHP'),
              Text(' Notions de base en reseaux informatiques'),
              Text(' Notions de base du developpement avec  flutter'),
            ],
          ),

          Padding(padding: const EdgeInsets.all(10)),
          Header(level: 1, child: Text('LANGUES', textScaleFactor: 2)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(' Tamazight : langue maternelle'),
              Text(' Arabe : courant'),
              Text(' Francais : courant'),
              Text(' Anglait : moyen'),

            ],
          ),

          Padding(padding: const EdgeInsets.all(10)),
          Header(level: 1, child: Text("CENTRES D'INTERET", textScaleFactor: 2)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(' Travail associatif'),
              Text(' Sport'),
              Text(' Dessin'),
              Text(' Peinture'),

            ],
          ),
            ]));
    //save PDF
  }
}

/*

Future<Uint8List> CvView(context) async {
    final Document pdf = Document();

    Stream<QuerySnapshot> data = Firestore.instance.collection('modele').snapshots();

    String name='ES-SAGHIR MARIEM';

    pdf.addPage(MultiPage(
        pageFormat:
        PdfPageFormat.a4.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        crossAxisAlignment: CrossAxisAlignment.start,
        header: (Context context) {
          if (context.pageNumber == 1) {
            return null;
          }
          return Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              decoration: const BoxDecoration(
                  border:
                  BoxBorder(bottom: true, width: 0.5, color: PdfColors.grey)),
              child: Text('ESSAGHIR Mariem',
                  style: Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey))
          );
        },
      /*  footer: (Context context) {
          return Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: Text('Page ${context.pageNumber} of ${context.pagesCount}',
                  style: Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },*/
        build: (Context context) => <Widget>[

              Container(
                color: PdfColors.black,

                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('$name',
                            style: TextStyle(color: PdfColors.white),
                            textScaleFactor: 2,
                        ),
                        Padding(padding: const EdgeInsets.all(20.0)),
                      ]
                    ),


                  ]
              ),
              ),

          Container(
            height: 30.0,
          ),
          Header(level: 1, child: Text( 'FORMATION',textScaleFactor: 2)),

          Container(
            child: Column(
              children: <Widget>[
                Wrap(
                  spacing: 40.0,
                  children: <Widget>[
                   Container(
                     color: PdfColors.grey,
                     width: 70.0,
                     height: 20.0,
                     child: Text(
                       '2016-2017'
                     ),
                   ),
                    Container(
                      color: PdfColors.grey,
                      width: 355.0,
                        child: Flexible(
                          child: Text('DEUG en sciences mathematiaue et informatique'),
                        )
                    ),

                  ],
                ),
                Padding(padding: const EdgeInsets.all(10)),
                Wrap(
                  spacing: 50.0,
                  children: <Widget>[
                    Container(
                      color: PdfColors.grey,
                      width: 70.0,
                      height: 20.0,
                      child: Text(
                          '2016-2017'
                      ),
                    ),
                    Container(
                        color: PdfColors.grey,
                        width: 355.0,
                        child: Flexible(
                          child: Text('Baccalaureat en science mathematiques A'),
                        )
                    ),

                  ],
                ),

              ],
            ),
          ),


          Padding(padding: const EdgeInsets.all(10)),
          Header(level: 1, child: Text( 'COMPETENCE',textScaleFactor: 2)),

        ]));
    //save PDF

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/report.pdf';
    final File file = File(path);
    await file.writeAsBytes(pdf.save());
    material.Navigator.of(context).pop();
    material.Navigator.of(context).push(
      material.MaterialPageRoute(
        builder: (_) => PdfPreview(path: path),
      ),
    );
}*/
