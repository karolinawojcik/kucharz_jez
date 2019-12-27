import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
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
              'Twój profil',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'AmaticSC',
              ),
            ),
          ),
          ],
          ),
        ),
      ),
    );
  }
}
