import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kucharz_jez/models/recipe.dart';
import 'package:kucharz_jez/screens/dish_page.dart';
import 'package:kucharz_jez/screens/home_page.dart';
import 'package:kucharz_jez/screens/profile_page.dart';
import 'package:kucharz_jez/screens/recipes_page.dart';
import 'package:kucharz_jez/screens/searching_page.dart';

class MainPage extends StatefulWidget{
  const MainPage({
    Key key,
    @required this.user
  }) : super(key: key);
  final FirebaseUser user;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{

  TabController _controller;
  @override
  void initState()  {
    super.initState();
    _controller = new TabController(vsync: this, length: 4, initialIndex: 0);
  }

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
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchingPage(),
          RecipesPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.red[600],
        child: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs:  <Widget>[
            Tab(
              icon: ImageIcon(
                  AssetImage('assets/home.png'),
                  size: 20,
              ),
            ),
            Tab(
              icon: ImageIcon(
                  AssetImage('assets/chef.png'),
                  size: 20,
              ),
            ),
            Tab(
              icon: ImageIcon(
                  AssetImage('assets/book.png'),
                  size: 20,
              ),
            ),
            Tab(
              icon: ImageIcon(
                AssetImage('assets/user.png'),
                size: 20,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}