import 'package:flutter/material.dart';
import 'package:cvmakerapp/api/cv_api.dart';
import 'package:cvmakerapp/screens/home.dart';
import 'package:cvmakerapp/notifier/auth_notifier.dart';
import 'package:provider/provider.dart';
import 'package:cvmakerapp/model/user.dart';

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
        labelStyle: TextStyle(color: Colors.white54),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
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
        labelStyle: TextStyle(color: Colors.white54),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
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
        labelStyle: TextStyle(color: Colors.white54),
      ),
      style: TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
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
        labelStyle: TextStyle(color: Colors.white54),
      ),
      style: TextStyle(fontSize: 26, color: Colors.white),
      cursorColor: Colors.white,
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
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        decoration: BoxDecoration(color: Color(0xff340560)),
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Authentification",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36, color: Colors.white),
                  ),
                  SizedBox(height: 32),
                  _authMode == AuthMode.Signup
                      ? _buildDisplayNameField()
                      : Container(),
                  _buildEmailField(),
                  _buildPasswordField(),
                  _authMode == AuthMode.Signup
                      ? _buildConfirmPasswordField()
                      : Container(),
                  SizedBox(height: 40),

                  ButtonTheme(
                    minWidth: 200,
                    child: RaisedButton(
                      color: Colors.white12,
                      padding: EdgeInsets.all(10.0),
                     // onPressed: () => _submitForm(),

                      onPressed: () {
                        _submitForm();
                        Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Home()));
                      },

                      child: Text(
                        _authMode == AuthMode.Login
                            ? 'Se connecter'
                            : "S'inscrire",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ButtonTheme(
                    minWidth: 200,
                    child: RaisedButton(
                      color: Colors.white12,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        ' Page ${_authMode == AuthMode.Login ? "Inscription" : 'Login'}',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.Login
                              ? AuthMode.Signup
                              : AuthMode.Login;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 16),
                  ButtonTheme(
                    minWidth: 200,
                    child: RaisedButton(
                      color: Colors.white12,
                      padding: EdgeInsets.all(10.0),
                      onPressed: () {
                        navigateToSubPage(context);
                      },
                      child: Text(
                        _authMode == AuthMode.Login
                            ? "Visualiser l'App"
                            : "Visualiser l'App",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future navigateToSubPage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
}
