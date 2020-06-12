import 'package:flutter/material.dart';
import 'package:cvmakerapp/screens/login.dart';
import 'package:cvmakerapp/notifier/auth_notifier.dart';
import 'package:provider/provider.dart';
import 'package:cvmakerapp/screens/home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hexcolor/hexcolor.dart';


/*final FirebaseApp app = FirebaseApp(
       options: FirebaseOptions(

    googleAppID: '1:925850939191:android:547af1c2d236d868a534b2',
    apiKey: 'AIzaSyB6vIDM4UaPyTJok_sV3u8SkyKUvHMSpa0',
    databaseURL: 'https://cv-maker-e725f.firebaseio.com',
  )
);
*/

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => AuthNotifier(), create: (BuildContext context) {  },
        )
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cv Maker',
      theme: ThemeData(
        primaryColor: Hexcolor('#774781'),
        accentColor: Colors.pinkAccent,
      ),
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          //return notifier.user != null ? Home() : Login();
          return Login();
        },
      ),
    );
  }
}

class Item {
  String key;
  String title;
  String body;

  Item(this.title, this.body);
  Item.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        body = snapshot.value["body"];

  toJson() {
    return {
      "title": title,
      "body": body,
    };
  }
}

