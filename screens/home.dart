import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cvmakerapp/screens/mescvs.dart';
import 'package:cvmakerapp/screens/pageModelscv.dart';
import 'package:cvmakerapp/notifier/auth_notifier.dart';
import 'package:provider/provider.dart';
import 'package:cvmakerapp/api/cv_api.dart';
import 'package:cvmakerapp/drawer.dart';


class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: new Text('Cv Maker App',
            style: TextStyle(
              color: Colors.black,
              fontFamily: "PlayfairDisplay",
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center),
      ),
      drawer: drawer(),
      body: Container(
        //width: 100.00,

        //height: 100.00,

        decoration: new BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Hexcolor('#997A8D')])),

        padding: EdgeInsets.all(20.0),

        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                      backgroundColor: Hexcolor('#774781'),
                      radius: 80.0,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/logo1.jpg'),
                        radius: 77.0,
                      )
                  ),
                  const Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
                        child: Text(
                          "Créez votre cv facilement ...\n Et explorez le monde professionnel.",
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "DancingScript",
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Center(child: CreerCVBoutton()),
            Center(
              child: MesCVBoutton(),
            ),
          ],
        ),
      ),
    );
  }
}

//************************************************ créer un cv

class CreerCVBoutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Container(
      margin: EdgeInsets.only(top: 60.0),
      width: 250.0,
      height: 50.0,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
        ),
        color: Hexcolor('#774781'),
        textColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PageModelsCv()));
        },
        child: Text(
          "Créer un CV",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "PlayfairDisplay",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

//************************************************ mes cv

class MesCVBoutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      margin: EdgeInsets.only(top: 40.0),
      width: 250.0,
      height: 50.0,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
        ),
        color: Hexcolor('#774781'),
        child: Text(
          "Mes CV",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "PlayfairDisplay",
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MesCv()));
        },
      ),
    );
  }
}
