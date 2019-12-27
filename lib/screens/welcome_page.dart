import 'package:flutter/material.dart';
import 'signin_page.dart';
import 'signup_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only( top: 40.0),
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
                      padding: const EdgeInsets.only(top: 5.0),
                      child: RaisedButton(
                        onPressed: navigateToSignIn,
                        color: Colors.red[600],
                        child: const Text(
                            'Zaloguj się',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'OpenSans',
                              color: Colors.white,
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
                      child: Text(
                        'Nie masz jeszcze konta?',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: RaisedButton(
                        onPressed: navigateToSignUp,
                        color: Colors.green[900],
                        child: const Text(
                            'Załóż konto',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'OpenSans',
                              color: Colors.white,
                            )
                        ),
                      ),
                    ),
                  ]
              ),
            )
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  void navigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage(), fullscreenDialog: true));
  }
  void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(), fullscreenDialog: true));
  }
}
