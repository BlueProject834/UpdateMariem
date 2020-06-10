class Titre {
  String title;

  Titre(
      this.title,
      );

  Map<String, dynamic> toJson() => {
    'title': title,
  };

}