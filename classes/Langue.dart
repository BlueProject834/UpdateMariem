class Langue {

  String langue;

  String niveau;

  Langue(

      this.langue,

      this.niveau

      );

  Map<String, dynamic> toJson() => {
    'Langue': langue,
    'Niveau': niveau
  };

}