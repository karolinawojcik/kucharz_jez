import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kucharz_jez/models/recipe.dart';
import 'package:kucharz_jez/models/user.dart';
import 'package:kucharz_jez/screens/results_page.dart';
import 'package:kucharz_jez/screens/shopping_list_page.dart';

class ProfilePage extends StatefulWidget {
  final AppUser user;

  const ProfilePage({Key key, this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  final List<String> options = <String>[
    'Polubione przepisy',
    'Lista zakupów',
    'Wyloguj'
  ];

  @override
  void initState() {
    updateUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.green,
      ),
    );
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      widget.user.email,
                      style: TextStyle(
                        fontSize: 34.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[900],
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
                      return ListTile(
                        onTap: () {
                          onOptionEnter(index);
                        },
                        title: Column(
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
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> onOptionEnter(int option) async {
    if (option == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShoppingListPage(user: widget.user)));
    }

    if (option == 0) {
      List<Recipe> recipes = [];
      QuerySnapshot querySnapshot =
          await Firestore.instance.collection('recipes').getDocuments();
      var list = querySnapshot.documents;
      for (var f in list) {
        if (widget.user.favoriteRecipes.contains(f.documentID)) {
          recipes.add(Recipe(
              int.parse(f.documentID),
              f['name'],
              f['image_url'],
              f['ingredients'],
              f['instruction'],
              f['types'],
              f['difficulty'],
              f['time']));
        }
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultsPage(
                  recipes: recipes,
                  user: widget.user,
                  message: 'POLUBIONE PRZEPISY')));
    }
    if (option == 2) {
      await updateUserData();
      Navigator.popUntil(
          context, ModalRoute.withName(Navigator.defaultRouteName));
    }
  }

  Future<void> updateUserData() async {
    await widget.user.updateData();
    setState(() {
      isLoading = false;
    });
  }
}
