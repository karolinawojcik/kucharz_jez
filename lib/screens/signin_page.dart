import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:kucharz_jez/models/user.dart';
import 'package:kucharz_jez/screens/main_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _email, _password;
  String errorMessage = ' ';
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.green,
      ),
    );
    return new Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/jez.png',
              fit: BoxFit.cover,
              height: 45,
              width: 45,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Kucharz Jeż',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red[600],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Form(
          key: _formKey,
          child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Image.asset(
                    'assets/jez.png',
                    fit: BoxFit.contain,
                    height: 200,
                    width: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Kucharz Jeż\nwie co zjesz!',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'AmaticSC',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 300,
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Podaj email';
                        }
                      },
                      onSaved: (input) => _email = input,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 15.0, bottom: 10.0, top: 10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 300,
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Podaj hasło';
                        } else if (input.length < 6) {
                          return 'Hasło musi mieć minimum 6 znaków';
                        }
                      },
                      onSaved: (input) => _password = input,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Hasło',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 15.0, bottom: 10.0, top: 10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: RaisedButton(
                    onPressed: signIn,
                    color: Colors.red[600],
                    child: const Text('Zaloguj',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'OpenSans',
                          color: Colors.white,
                        )),
                  ),
                ),
                Text(errorMessage,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                      color: Colors.red[600],
                    )),
              ]),
        )),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password))
            .user;
        setState(() {
          errorMessage = ' ';
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MainPage(user: new AppUser(user.uid, user.email))));
      } catch (e) {
        print(e.message);
        setState(() {
          errorMessage = 'Wprowadzono niepoprawne dane';
        });
      }
    }
  }
}
