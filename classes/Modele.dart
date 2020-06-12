class Modele{
  String _ID;
  String _nom;
  String _image;

  Modele(this._ID);

  String get ID => _ID;
  String get image => _image;
  set image(String value) {
    _image = value;
  }
  String get nom => _nom;
  set nom(String value) {
    _nom = value;
  }


  @override
  String toString() {
    return 'Modele{_ID: $_ID, _nom: $_nom, _image: $_image}';
  }


}