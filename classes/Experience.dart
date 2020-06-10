class Experience {

  String anneeDebE;
  String anneeFinE;
  String titreE;
  String institut;

  Experience(
      this.anneeDebE,
      this.anneeFinE,
      this.titreE,
      this.institut
      );


  Map<String, dynamic> toJson() => {
    'Année du début': anneeDebE,
    'Année fin': anneeFinE,
    'Titre': titreE,
    'Institut': institut
  };

}