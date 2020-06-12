import 'package:cloud_firestore/cloud_firestore.dart';

class Titre {

  String title;

  Titre(
      this.title,
      );

  Map<String, dynamic> toJson() => {
    'title': title,
  };

  Titre.fromSnapshot(DocumentSnapshot snapshot)
      : title = snapshot['title'];

}