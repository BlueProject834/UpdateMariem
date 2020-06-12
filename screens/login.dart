import 'package:flutter/material.dart';
import 'package:cvmakerapp/api/cv_api.dart';
import 'package:cvmakerapp/screens/home.dart';
import 'package:cvmakerapp/notifier/auth_notifier.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:cvmakerapp/model/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum AuthMode { Signup, Login }

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = new TextEditingController();

  AuthMode _authMode = AuthMode.Login;

  User _user = User();

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    initializeCurrentUser(authNotifier);

    super.initState();
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    if (_authMode == AuthMode.Login) {
      login(_user, authNotifier);
    } else {
      signup(_user, authNotifier);
    }
  }

  Widget _buildDisplayNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nom",
        labelStyle: TextStyle(color: Colors.black45),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20, color: Colors.black),
      cursorColor: Colors.black,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Veuillez remplir le champ';
        }

        if (value.length < 5 || value.length > 12) {
          return 'Le nom doit être entre 5 et 12 caractères';
        }

        return null;
      },
      onSaved: (String value) {
        _user.displayName = value;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Adresse Email",
        labelStyle: TextStyle(color: Colors.black45),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 20, color: Colors.black),
      cursorColor: Colors.black,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Veuillez remplir le champ';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Veuillez entre une adresse email valide';
        }

        return null;
      },
      onSaved: (String value) {
        _user.email = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Mot de passe",
        labelStyle: TextStyle(color: Colors.black45),
      ),
      style: TextStyle(fontSize: 20, color: Colors.black),
      cursorColor: Colors.black,
      obscureText: true,
      controller: _passwordController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Veuillez remplir le champ';
        }

        if (value.length < 5 || value.length > 20) {
          return 'Mot de passe doit être entre 5 et 20 caractères';
        }

        return null;
      },
      onSaved: (String value) {
        _user.password = value;
      },
    );
  }


  Widget _buildConfirmPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Confirmer le mot de passe",
        labelStyle: TextStyle(color: Colors.black45),
      ),
      style: TextStyle(fontSize: 20, color: Colors.black),
      cursorColor: Colors.black,
      obscureText: true,
      validator: (String value) {
        if (_passwordController.text != value) {
          return 'Les deux mots de passe ne sont pas identiques';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building login screen");

    return Scaffold(
      body:
 /*    Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/1.jpg"),
            fit: BoxFit.cover,),
        ),*/
      Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        decoration: new BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topCenter,
                colors: [/*Hexcolor('#997A8D')*/Colors.white12, Colors.white12])),

        child: Form(
          autovalidate: true,
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32, 56, 32, 0),
              child: Column(
                children: <Widget>[
                  _authMode == AuthMode.Signup
                      ? Container(
                    child: Text(
                      "Inscription",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "PlayfairDisplay",
                          fontWeight: FontWeight.w700,
                          fontSize: 36,
                          color: Colors.black),
                    ),
                  )
                      : Column(
                    children: <Widget>[
                      Text(
                        "Bienvenue \n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: "DancingScript",
                            fontWeight: FontWeight.w700,
                            color: Hexcolor('#774780')),
                      ),
                      Text(
                        "Authentification",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "PlayfairDisplay",
                            fontWeight: FontWeight.w700,
                            fontSize: 36,
                            color: Colors.black
                        ),
                      ),
                    ],),
                  SizedBox(height: 32),
                  _authMode == AuthMode.Signup
                      ? _buildDisplayNameField()
                      : Container(),
                  _buildEmailField(),
                  _buildPasswordField(),
                  _authMode == AuthMode.Signup
                      ? _buildConfirmPasswordField()
                      : Container(),
                  SizedBox(height: 60),

                  ButtonTheme(
                    minWidth: 200,
                    child: Container(
                      width: 300.0,
                      child:
                    RaisedButton(
                      color: Hexcolor("#774780"),
                      padding: EdgeInsets.all(10.0),
                      onPressed: () {
                        _submitForm();
                        Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Home()));
                      },

                      child: Text(
                        _authMode == AuthMode.Login
                            ? 'Se connecter'
                            : "S'inscrire",
                        style: TextStyle(
                            fontFamily: "PlayfairDisplay",
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.white70
                        ),
                      ),
                    ),
                  ),
                  ),
                  SizedBox(height: 8),
                  ButtonTheme(
                    minWidth: 200,
                    child:
                    Container(
                      width: 300,
                      child: RaisedButton(
                      color: Hexcolor("#774780"),
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '  ${_authMode == AuthMode.Login ? "S'inscrire " : 'Se connecter'}',
                        style: TextStyle(
                            fontFamily: "PlayfairDisplay",
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.white70),
                      ),
                      onPressed: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.Login
                              ? AuthMode.Signup
                              : AuthMode.Login;
                        });
                      },
                    ),),
                  ),

                  SizedBox(height: 8),
                  ButtonTheme(
                    minWidth: 200,
                    child: Container(
                      width: 300,
                      child: RaisedButton(
                      color: Hexcolor("#774780"),
                      padding: EdgeInsets.all(10.0),
                        onPressed: () {
                          showAlertDialog(context);
                        },
                         child: Text(
                        _authMode == AuthMode.Login
                            ? "Visualiser l'Application"
                            : "Visualiser l'Application",
                        style: TextStyle(
                            fontFamily: "PlayfairDisplay",
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.white70),
                      ),
                    ),),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("Se connecter",
      style: TextStyle(
        fontSize: 17,
        color: Hexcolor("#774780"),
      ),),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Continuer",
    style: TextStyle(
      fontSize: 17,
      color: Hexcolor("#774780"),
    ),
    ),
    onPressed:  () {
      navigateToSubPage(context);
    },
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: Hexcolor('#FFFFF2'),
    shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20.0)),
    title: Text("Merci pour utiliser cette application"),
    content: Text("En continuant sans connexion vous pouvez découvrire l'application mais non pas créer des CV.\n\nInscrivez vous pour une meilleure expérience !"),
    actions: [
      okButton,
      continueButton
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future navigateToSubPage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
}
