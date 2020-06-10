class Formation {

  String anneeDebF;

  String anneeFinF;

  String diplome;

  String institut;

  String descriptionF;



  Formation(

      this.anneeDebF,

      this.anneeFinF,

      this.descriptionF,

      this.diplome,

      this.institut

      );





  Map<String, dynamic> toJson() => {

    'Année du début': anneeDebF,

    'Année fin': anneeFinF,

    'Diplôme': diplome,

    'Institut': institut,

    'Description': descriptionF

  };

}