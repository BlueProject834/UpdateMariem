import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../drawer.dart';
import '../finFormulaire.dart';

/*
class MesCv extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
    );
  }
}
*/
class MesCv extends StatefulWidget {
  MesCv({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MesCvState createState() => _MesCvState();
}

class _MesCvState extends State<MesCv> {
  // this was added to main.dart after making _user static:   create: (BuildContext context) {  },
  static String _user;

  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      _user = user.uid;
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Mes CV",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "PlayfairDisplay",
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        endDrawer: drawer(),
        body: StreamBuilder(
        stream: Firestore.instance
            .collection('userData')
        .document(_user)
        .collection('Cv')
        .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
            return const Text(" VOUS N'AVEZ PAS ENCORE ENREGISTRE DE CV");
             } else {
             return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
              DocumentSnapshot cv = snapshot.data.documents[index];
              return Stack(
                children: <Widget>[
                Column(
                  children: <Widget>[
                   Container(
                   padding: EdgeInsets.only(top: 5.0, bottom: 0.0),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                    color: Hexcolor('#E6E6E6'),
                    borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                       topRight: Radius.circular(10.0),
                     ),
                   ),
                    child: Container(
                         child: ListTile(
                            title: new Text(
                            "${cv['nomCv']}",
                              style: TextStyle(
                            color: Colors.black,
                            fontFamily: "PlayfairDisplay",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          trailing: IconButton(
                             icon: Icon(Icons.delete),
                             onPressed: () {
                               showDialog(context: context,
                                 builder: (BuildContext context) {
                                   return Dialog(
                                     shape: RoundedRectangleBorder(
                                         borderRadius:
                                         BorderRadius.circular(20.0)),
                                     //this right here
                                     child: Container(
                                       height: 200,
                                       child: Padding(
                                         padding: const EdgeInsets.all(12.0),
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment
                                               .center,
                                           crossAxisAlignment: CrossAxisAlignment
                                               .start,
                                           children: [
                                             Text(
                                                 "Etes vous sur de vouloir supprimer ce cv ?"),
                                             SizedBox(
                                               width: 320.0,
                                               child: RaisedButton(
                                                 onPressed: () {
                                                   String docId = snapshot
                                                       .data.documents[index]
                                                       .documentID;
                                                   Firestore.instance
                                                       .collection('userData')
                                                       .document(_user)
                                                       .collection('Cv')
                                                       .document(docId)
                                                       .delete()
                                                       .catchError((e) {
                                                     print(e);
                                                   });
                                                   Navigator.pop(context);
                                                   Navigator.push(
                                                       context,
                                                       MaterialPageRoute(
                                                           builder: (
                                                               context) => new MesCv()));
                                                 },

                                                 child: Text("Oui",
                                                   style: TextStyle(
                                                       color: Colors.white),),
                                                 color: Hexcolor('#774781'),
                                               ),
                                             ),

                                             SizedBox(
                                               width: 320.0,
                                               child: RaisedButton(
                                                 onPressed: () {
                                                   Navigator.pop(context);
                                                   Navigator.push(
                                                       context,
                                                       MaterialPageRoute(
                                                           builder: (
                                                               context) => new MesCv()));
                                                 },

                                                 child: Text("Non",
                                                   style: TextStyle(
                                                       color: Colors.white),),
                                                 color: Hexcolor('#774781'),
                                               ),
                                             )
                                           ],
                                         ),
                                       ),
                                     ),
                                   );
                                 },
                               );
                             }),
                              onTap: () {
                            //  Navigator.pop(context);
                              Navigator.push(context,MaterialPageRoute(builder: (context) =>new pageFinFormulaire()));
                             }
    ),
    ),
    ),
    ],
    ),
    ],
    );
    },
    );
    }
    },
    ),
    );
    }
  }
