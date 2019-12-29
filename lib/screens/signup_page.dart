//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:kucharz_jez/models/user.dart';
//import 'package:kucharz_jez/screens/signin_page.dart';
//
//class SignUpPage extends StatefulWidget {
//  @override
//  _SignUpPageState createState() => new _SignUpPageState();
//}
//
//class _SignUpPageState extends State<SignUpPage> {
//  String _email, _password;
//  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//
//  @override
//  Widget build (BuildContext context) {
//    return new Scaffold(
//      appBar: AppBar(
//        title: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            Image.asset(
//              'assets/jez.png',
//              fit: BoxFit.cover,
//              height: 45,
//              width: 45,
//            ),
//            Container(
//              padding: const EdgeInsets.all(8.0),
//              child: Text(
//                'Kucharz Jeż',
//                style: TextStyle(
//                  fontFamily: 'OpenSans',
//                  color: Colors.white,
//                ),
//              ),
//            ),
//          ],
//        ),
//        backgroundColor: Colors.red[600],
//      ),
//      body: SingleChildScrollView(
//        child: Center(
//            child: Form(
//              key: _formKey,
//              child: Column(
//                // mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.only( top: 40.0),
//                      child: Image.asset(
//                        'assets/jez.png',
//                        fit: BoxFit.contain,
//                        height: 200,
//                        width: 200,
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(bottom: 10.0),
//                      child: Text(
//                        'Kucharz Jeż\nwie co zjesz!',
//                        style: TextStyle(
//                          fontSize: 40.0,
//                          fontWeight: FontWeight.bold,
//                          color: Colors.black,
//                          fontFamily: 'AmaticSC',
//                        ),
//                      ),
//                    ),
////                    Padding(
////                      padding: const EdgeInsets.all(5.0),
////                      child: Container(
////                        width: 300,
////                        child: TextFormField(
////                          validator: (input) {
////                            if(input.isEmpty){
////                              return 'Podaj nazwę użytkownika';
////                            }return '';
////                          } ,
////                          onSaved: (input) => _username = input,
////                          decoration: InputDecoration(
////                            border: OutlineInputBorder(),
////                            labelText: 'Nazwa użytkownika',
////                            filled: true,
////                            fillColor: Colors.white,
////                            contentPadding: const EdgeInsets.only(
////                                left: 15.0,
////                                bottom: 10.0,
////                                top: 10.0
////                            ),
////                          ),
////                        ),
////                      ),
////                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(5.0),
//                      child: Container(
//                        width: 300,
//                        child: TextFormField(
//                          validator: (input) {
//                            if(input.isEmpty){
//                              return 'Podaj email';
//                            }return '';
//                          } ,
//                          onSaved: (input) => _email = input,
//                          decoration: InputDecoration(
//                            border: OutlineInputBorder(),
//                            labelText: 'Email',
//                            filled: true,
//                            fillColor: Colors.white,
//                            contentPadding: const EdgeInsets.only(
//                                left: 15.0,
//                                bottom: 10.0,
//                                top: 10.0
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(5.0),
//                      child: Container(
//                        width: 300,
//                        child: TextFormField(
//                          validator: (input) {
//                            if (input.isEmpty) {
//                              return 'Podaj hasło';
//                            }
//                            else if (input.length < 6) {
//                              return 'Hasło musi mieć minimum 6 znaków';
//                            }
//                            return '';
//                          },
//                          onSaved: (input) => _password = input,
//                          obscureText: true,
//                          decoration: InputDecoration(
//                            border: OutlineInputBorder(),
//                            labelText: 'Hasło',
//                            filled: true,
//                            fillColor: Colors.white,
//                            contentPadding: const EdgeInsets.only(
//                                left: 15.0,
//                                bottom: 10.0,
//                                top: 10.0
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(top: 5.0),
//                      child: RaisedButton(
//                        onPressed: signUp,
//                        color: Colors.red[600],
//                        child: const Text(
//                            'Zarejestruj',
//                            style: TextStyle(
//                              fontSize: 16,
//                              fontFamily: 'OpenSans',
//                              color: Colors.white,
//                            )
//                        ),
//                      ),
//                    ),
//                  ]
//              ),
//            )
//        ),
//      ),
//      backgroundColor: Colors.grey[200],
//    );
//  }
//
//  Future<void> signUp() async{
//    final formState = _formKey.currentState;
//    if(formState.validate()){
//      formState.save();
//      try{
//        FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
//        user.sendEmailVerification();
//        Navigator.of(context).pop();
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()));
//      }
//      catch(e){
//        print(e.message);
//      }
//      //createUser();
//    }
//  }
////
////  Future<void> createUser() async {
////    List<AppUser> users = [];
////    QuerySnapshot querySnapshot = await Firestore.instance.collection('users').getDocuments();
////    var list = querySnapshot.documents;
////    for(var f in list){
////      users.add(new AppUser(
////          int.parse(f.documentID),
////          f['username'],
////          f['email']));
////    }
////    var newUser = new AppUser(
////        users.length,
////       _username,
////        _email);
////    await Firestore.instance.collection('users').document(newUser.id.toString()).setData({
////      'username': newUser.userName,
////      'email': newUser.email,
////      'favorite_recipes': newUser.favoriteRecipes,
////      'shopping_list': newUser.shoppingList,
////    });
////
////    Navigator.of(context).pop();
////    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()));
////  }
//}
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kucharz_jez/screens/signin_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build (BuildContext context) {
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
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: 300,
                        child: TextFormField(
                          validator: (input) {
                            if(input.isEmpty){
                              return 'Podaj email';
                            }
                          } ,
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(
                                left: 15.0,
                                bottom: 10.0,
                                top: 10.0
                            ),
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
                            }
                            else if (input.length < 6) {
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
                                left: 15.0,
                                bottom: 10.0,
                                top: 10.0
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: RaisedButton(
                        onPressed: signUp,
                        color: Colors.red[600],
                        child: const Text(
                            'Zarejestruj',
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

  Future<void> signUp() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
        user.sendEmailVerification();
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()));
      }
      catch(e){
        print(e.message);
      }
    }
  }
}