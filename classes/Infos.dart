class Infos{

  String nom;

  String prenom;

  String numtel;

  String adresse;

  String codepostal;

  String email;

  String datenaissance;

  String nationalite;

  String etatcivil;

  String permis;



  Infos(

      this.nom,

      this.prenom,

      this.numtel,

      this.adresse,

      this.codepostal,

      this.email,

      this.datenaissance,

      this.nationalite,

      this.etatcivil,

      this.permis,



      );





  Map<String, dynamic> toJson() => {

    'Nom': nom,
    'Prénom': prenom,
    'Num Tél': numtel,
    'Adresse': adresse,
    'Code Postal': codepostal,
    'Email': email,
    'Date Naissance': datenaissance,
    'Nationalité': nationalite,
    'Etat Civil': etatcivil,
    'Permis': permis,

  };

}