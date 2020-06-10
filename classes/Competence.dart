class Competence {

  String title;

  String descriptionC;





  Competence(

      this.title,

      this.descriptionC

      );



  Map<String, dynamic> toJson() => {

    'Titre': title,

    'Description': descriptionC

  };

}