class Interet {

  String title;

  String descriptionI;





  Interet(

      this.title,

      this.descriptionI

      );



  Map<String, dynamic> toJson() => {

    'Titre': title,

    'Description': descriptionI

  };

}