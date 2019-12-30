import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kucharz_jez/models/recipe.dart';
import 'package:kucharz_jez/models/user.dart';
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
  final AppUser user;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{
  bool isLoading = true;
  TabController _controller;
  AppUser loggedInUser;

  @override
  void initState()  {
    loggedInUser = widget.user;
    createUser();
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
      body: isLoading
          ? Center(child:CircularProgressIndicator(),)
          : TabBarView(
        controller: _controller,
        children: <Widget>[
          HomePage(user: loggedInUser),
          SearchingPage(user: loggedInUser),
          RecipesPage(user: loggedInUser),
          ProfilePage(user: loggedInUser),
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

  Future<void> createUser() async {
    List<AppUser> users = [];
    String uid;
    String email;
    List<dynamic> favoriteRecipes;
    List<dynamic> shoppingList;

    QuerySnapshot querySnapshot = await Firestore.instance.collection('/users').getDocuments();
    var list = querySnapshot.documents;
    for(var f in list){
      var usr = new AppUser(
          f.documentID,
          f['email']);
      usr.favoriteRecipes = f['favorite_recipes'];
      usr.shoppingList = f['shopping_list'];
      users.add(usr);
    }
    bool isExisting = false;
    for(var i in users){
      if(i.email == widget.user.email){
        isExisting = true;
        uid = i.id;
        email = i.email;
        favoriteRecipes = i.favoriteRecipes;
        shoppingList = i.shoppingList;
      }
    }
    if(!isExisting){
     Firestore.instance.collection('/users').add({
        'email': widget.user.email,
        'favorite_recipes': widget.user.favoriteRecipes,
        'shopping_list': widget.user.shoppingList,
      }).then((value){
       setState(() {
         isLoading = false;
       });
     }).catchError((e){
       print(e);
     });
    }
    else{
        var loggedUser = new AppUser(uid,email);
        loggedInUser.favoriteRecipes = favoriteRecipes;
        loggedInUser.shoppingList = shoppingList;
        setState(() {
          loggedInUser = loggedUser;
          isLoading = false;
        });
    }
    setState(() {
      isLoading = false;
    });
  }
}