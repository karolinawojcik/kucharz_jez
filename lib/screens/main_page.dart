import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kucharz_jez/models/user.dart';
import 'package:kucharz_jez/screens/home_page.dart';
import 'package:kucharz_jez/screens/profile_page.dart';
import 'package:kucharz_jez/screens/recipes_page.dart';
import 'package:kucharz_jez/screens/searching_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key, @required this.user}) : super(key: key);
  final AppUser user;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  TabController _controller;
  AppUser loggedInUser;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
      ),
    );
    loggedInUser = widget.user;
    createUser();
    super.initState();
    _controller = new TabController(vsync: this, length: 4, initialIndex: 0);
  }

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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
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
          tabs: <Widget>[
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
    List<dynamic> favoriteRecipes = [];
    List<dynamic> shoppingList = [];
    List<dynamic> recipesForToday = [];
    int timeOfLastGenerating;

    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('users').getDocuments();
    var list = querySnapshot.documents;
    for (var f in list) {
      var usr = new AppUser(f.documentID, f['email']);
      usr.favoriteRecipes = f['favorite_recipes'].length == 0
          ? []
          : List.from(f['favorite_recipes'], growable: true);
      usr.shoppingList = f['shopping_list'].length == 0
          ? []
          : List.from(f['shopping_list'], growable: true);
      usr.recipesForToday = f['recipes_for_today'].length == 0
          ? []
          : List.from(f['recipes_for_today'], growable: true);
      usr.timeOfLastGenerating = f['time_of_last_generating'];
      users.add(usr);
    }
    bool isExisting = false;
    for (var i in users) {
      if (i.email == widget.user.email) {
        isExisting = true;
        uid = i.id;
        email = i.email;
        favoriteRecipes = i.favoriteRecipes;
        shoppingList = i.shoppingList;
        recipesForToday = i.recipesForToday;
        timeOfLastGenerating = i.timeOfLastGenerating;
      }
    }
    if (!isExisting) {
      Firestore.instance.collection('/users').add({
        'email': widget.user.email,
        'favorite_recipes': widget.user.favoriteRecipes,
        'recipes_for_today': widget.user.recipesForToday,
        'shopping_list': widget.user.shoppingList,
        'time_of_last_generating': 0,
      }).then((value) {
        setState(() {
          isLoading = false;
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      var loggedUser = new AppUser(uid, email);
      loggedUser.favoriteRecipes = favoriteRecipes;
      loggedUser.shoppingList = shoppingList;
      loggedUser.recipesForToday = recipesForToday;
      loggedUser.timeOfLastGenerating = timeOfLastGenerating;
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
