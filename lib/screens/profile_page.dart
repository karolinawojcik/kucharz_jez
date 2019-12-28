import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> options = <String>['Polubione przepisy', 'Lista zakupów'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                'Twój profil',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontFamily: 'AmaticSC',
                ),
              ),
            ),
            Divider(color: Colors.black87),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                'Username',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  fontFamily: 'AmaticSC',
                ),
              ),
            ),
            Divider(color: Colors.black87),
            ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: options.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Text(
                      options[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                        fontFamily: 'AmaticSC',
                        fontSize: 34,
                      ),
                    ),
                    Divider(color: Colors.black87),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
