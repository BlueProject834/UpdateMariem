import 'package:cvmakerapp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cvmakerapp/screens/home.dart';
import 'package:cvmakerapp/screens/mescvs.dart';
import 'package:cvmakerapp/screens/pageModelscv.dart';
import 'package:firebase_auth/firebase_auth.dart';


class drawer extends StatefulWidget {
  drawer({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  String isConnectedName(){
    String name = user?.displayName;
    String notconnected=" ";
    if(name!=null)
      return name;
    else
      return notconnected;
  }

  String isConnectedEmail(){
    String email = user?.email;
    String notconnected="Vous n'etes pas connecté";
    if(email!=null)
      return email;
    else
      return notconnected;
  }
  String isConnected(){
    String email = user?.email;
    String connected="Se déconnecter";
    String notconnected="Se connecter";
    if(email!=null)
      return connected;
    else
      return notconnected;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 250.0,
      child: Drawer(
        child: //Stack(
            // children: <Widget>[
            ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("${isConnectedName()}"),
              accountEmail: Text("${isConnectedEmail()}"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo1.jpg'),
                radius: 30.0,
              ),
            ),
            Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Hexcolor('#FFFFFF')])),
                  child: new ListTile(
                      leading: new Icon(Icons.home),
                      title: new Text(
                        "Acceuil",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "PlayfairDisplay",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Home()));
                      }),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Hexcolor('#FFFFFF')])),
                  child: new ListTile(
                      leading: new Icon(Icons.add),
                      title: new Text(
                        "Créer un CV ",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "PlayfairDisplay",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new PageModelsCv()));
                      }),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Hexcolor('#FFFFFF')])),
                  child: new ListTile(
                      leading: new Icon(Icons.save),
                      title: new Text(
                        "Mes CV",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "PlayfairDisplay",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new MesCv()));
                      }),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Hexcolor('#FFFFFF')])),
                  child: new ListTile(
                      leading: new Icon(Icons.help_outline),
                      title: new Text(
                        "A propos",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "PlayfairDisplay",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new MesCv()));
                      }),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Hexcolor('#FFFFFF')])),
                  child: new ListTile(
                      leading: new Icon(Icons.mail),
                      title: new Text(
                        "Contactez-nous",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "PlayfairDisplay",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new MesCv()));
                      }),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Hexcolor('#FFFFFF')])),
                  child: new ListTile(
                      leading: new Icon(Icons.power_settings_new),
                      title: new Text(
                        "${isConnected()}",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "PlayfairDisplay",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () {
                        Future <Null> logout() async {
                          await FirebaseAuth.instance.signOut();
                          setState((){
                            FirebaseAuth.instance.currentUser;
                          });
                        }
                        logout();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Login()));
                      }),
                ),
              ],
            ),
          ],
        ),
        //  ],
        //   ),
      ),
    );
  }
}
