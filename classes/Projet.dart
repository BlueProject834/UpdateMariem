class Projet {
  String title;
  String descriptionP;

  Projet(
      this.title,
      this.descriptionP
      );


  Map<String, dynamic> toJson() => {
    'Titre': title,
    'Description': descriptionP
  };

}