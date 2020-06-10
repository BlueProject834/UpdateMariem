import 'package:cloud_firestore/cloud_firestore.dart';

class Cv{
  String id;
  String nomCV;
  String modeleCV;

  Cv(this.nomCV,);

  Map<String, dynamic> toJson() => {
    'nomCv': nomCV,
  };

}