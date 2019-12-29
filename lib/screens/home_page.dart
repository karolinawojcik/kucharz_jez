import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kucharz_jez/models/recipe.dart';
import 'package:kucharz_jez/models/user.dart';
import 'package:kucharz_jez/screens/dish_page.dart';
import 'package:dart_random_choice/dart_random_choice.dart';

//class RecipeCard extends StatelessWidget {
//  final Recipe recipe;
//  final bool inFavorites;
//  final Function onFavoriteButtonPressed;
//
//  RecipeCard(
//      {@required this.recipe,
//      @required this.inFavorites,
//      @required this.onFavoriteButtonPressed});
//
//  @override
//  Widget build(BuildContext context) {
//    RawMaterialButton _buildFavoriteButton() {
//      return RawMaterialButton(
//        constraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
//        onPressed: () => onFavoriteButtonPressed(recipe.id),
//        child: Icon(
//          // Conditional expression:
//          // show "favorite" icon or "favorite border" icon depending on widget.inFavorites:
//          inFavorites == true ? Icons.favorite : Icons.favorite_border,
//        ),
//        elevation: 2.0,
//        fillColor: Colors.white,
//        shape: CircleBorder(),
//      );
//    }
//
//    Padding _buildTitleSection() {
//      return Padding(
//        padding: EdgeInsets.all(15.0),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Text(
//              recipe.name,
//              style: TextStyle(
//                fontWeight: FontWeight.w400,
//                color: Colors.black87,
//                fontFamily: 'OpenSans',
//                fontSize: 30,
//              ),
//            ),
//            SizedBox(height: 10.0),
//            Row(
//              children: <Widget>[
//                Icon(Icons.timer, size: 20.0),
//                SizedBox(width: 5.0),
//                Text(
//                  recipe.time.toString() + ' min',
//                  style: TextStyle(
//                    fontWeight: FontWeight.w300,
//                    color: Colors.black87,
//                    fontFamily: 'OpenSans',
//                    fontStyle: FontStyle.italic,
//                    fontSize: 18,
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ),
//      );
//    }
//
//    return GestureDetector(
//      onTap: () => print("Tapped!"),
//      child: Padding(
//        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//        child: Card(
//          child: Column(
//            mainAxisSize: MainAxisSize.min,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              // We overlap the image and the button by
//              // creating a Stack object:
//              Stack(
//                children: <Widget>[
//                  AspectRatio(
//                    aspectRatio: 16.0 / 9.0,
//                    child: Image.network(
//                      recipe.imageUrl,
//                      fit: BoxFit.cover,
//                    ),
//                  ),
//                  Positioned(
//                    child: _buildFavoriteButton(),
//                    top: 2.0,
//                    right: 2.0,
//                  ),
//                ],
//              ),
//              _buildTitleSection(),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}

class HomePage extends StatefulWidget {
  final AppUser user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> recipes = [];
  bool isLoading = true;
  List<Recipe> recipesForToday = [];

  @override
  void initState() {
    getAllRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Kucharz Jeż poleca:',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'AmaticSC',
                  ),
                ),
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: recipesForToday.length,
                      itemBuilder: (context, index) => Column(
                        children: <Widget>[
                          new ListTile(
                              onTap: () {},
                              title: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DishPage(
                                              recipeId:
                                                  recipesForToday[index].id,
                                              user: widget.user)));
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Stack(
                                          children: <Widget>[
                                            AspectRatio(
                                              aspectRatio: 16.0 / 9.0,
                                              child: Image.network(
                                                recipesForToday[index].imageUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              child: RawMaterialButton(
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth: 40.0,
                                                        minHeight: 40.0),
                                                onPressed: () {},
                                                child: Icon(
                                                  // Conditional expression:
                                                  // show "favorite" icon or "favorite border" icon depending on widget.inFavorites:
                                                  Icons
                                                      .favorite, // : Icons.favorite_border,
                                                ),
                                                elevation: 2.0,
                                                fillColor: Colors.white,
                                                shape: CircleBorder(),
                                              ),
                                              top: 2.0,
                                              right: 2.0,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 5.0),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                recipesForToday[index].name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black87,
                                                  fontFamily: 'OpenSans',
                                                  fontSize: 22,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                              ),
                                            ),
                                            SizedBox(height: 5.0),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                              child: Row(children: <Widget>[
                                                SizedBox(width: 5.0),
                                                Icon(Icons.timer, size: 25.0),
                                                SizedBox(width: 5.0),
                                                Text(
                                                  recipesForToday[index]
                                                          .time
                                                          .toString() +
                                                      ' min',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.black87,
                                                    fontFamily: 'OpenSans',
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                SizedBox(width: 10.0),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 3.0),
                                                  child:
                                                      displayDifficulty(index),
                                                ),
                                                SizedBox(width: 5.0),
                                                Text(
                                                  difficultyString(
                                                      recipesForToday[index]
                                                          .difficulty),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.black87,
                                                    fontFamily: 'OpenSans',
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
//              StreamBuilder(
//                stream:
//                    Firestore.instance.collection('recipes').snapshots(),
//                builder: (context, snapshot) {
//                  if (!snapshot.hasData)
//                    return const Text(
//                      'Loading',
//                      style: TextStyle(
//                        fontSize: 22,
//                        fontFamily: 'OpenSans',
//                        color: Colors.black87,
//                      ),
//                    );
//                  return ListView.builder(
//                    physics: NeverScrollableScrollPhysics(),
//                    //itemCount: snapshot.data.documents.length,
//                    itemCount: 1,
//                    itemBuilder: (context, index) {
//                      return ListTile(
//                        title: Text('kurczaczek'),
              //Card(
//                          child: Column(
//                            mainAxisSize: MainAxisSize.min,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              // We overlap the image and the button by
//                              // creating a Stack object:
//                              Stack(
//                                children: <Widget>[
//                                  AspectRatio(
//                                    aspectRatio: 16.0 / 9.0,
//                                    child: Image.network(
//                                      'https://kuron.com.pl/wp-content/uploads/2018/09/P9120393.jpg',
//                                      fit: BoxFit.cover,
//                                    ),
//                                  ),
//                                  Positioned(
//                                    child: RawMaterialButton(
//                                      //constraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
//                                      onPressed: () {},
//                                      child: Icon(
//                                        // Conditional expression:
//                                        // show "favorite" icon or "favorite border" icon depending on widget.inFavorites:
//                                        Icons.favorite, //: Icons.favorite_border,
//                                      ),
//                                      elevation: 2.0,
//                                      fillColor: Colors.white,
//                                      shape: CircleBorder(),
//                                    ),
////                                    top: 2.0,
////                                    right: 2.0,
//                                  ),
//                                ],
//                              ),
//                              Padding(
//                                padding: EdgeInsets.all(15.0),
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text(
//                                      'Kurczak z warzywami',
//                                      style: TextStyle(
//                                        fontWeight: FontWeight.w400,
//                                        color: Colors.black87,
//                                        fontFamily: 'OpenSans',
//                                        fontSize: 30,
//                                      ),
//                                    ),
//                                    SizedBox(height: 10.0),
//                                    Row(
//                                      children: <Widget>[
//                                        Icon(Icons.timer, size: 20.0),
//                                        SizedBox(width: 5.0),
//                                        Text(
//                                          '90 min',
//                                          style: TextStyle(
//                                            fontWeight: FontWeight.w300,
//                                            color: Colors.black87,
//                                            fontFamily: 'OpenSans',
//                                            fontStyle: FontStyle.italic,
//                                            fontSize: 18,
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                        title: new RecipeCard(
////                        recipe: new Recipe(
////                            int.parse(
////                                snapshot.data.documents[index].documentID),
////                            snapshot.data.documents[index]['name'],
////                            snapshot.data.documents[index]['image_url'],
////                            snapshot.data.documents[index]['ingredients'],
////                            snapshot.data.documents[index]['instruction'],
////                            snapshot.data.documents[index]['types'],
////                            snapshot.data.documents[index]['difficulty'],
////                            snapshot.data.documents[index]['time']),
//                          recipe: new Recipe(
//                              1,
//                              'name',
//                              'https://kuron.com.pl/wp-content/uploads/2018/09/P9120393.jpg',
//                              ['ingredients'],
//                              ['instruction'],
//                              ['types'],
//                              2,
//                              90),
//                          inFavorites: true,
//                          onFavoriteButtonPressed: () {},
//                        ),
//                      );
//                    },
//                  );
//                },
//              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getAllRecipes() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('recipes').getDocuments();
    var list = querySnapshot.documents;
    for (var f in list) {
      recipes.add(new Recipe(
          int.parse(f.documentID),
          f['name'],
          f['image_url'],
          f['ingredients'],
          f['instruction'],
          f['types'],
          f['difficulty'],
          f['time']));
    }
    randomRecipesForDay();
    setState(() {
      isLoading = false;
    });
  }

  String difficultyString(int difficulty) {
    if (difficulty == 1) return 'łatwe';
    if (difficulty == 2) return 'średnie';
    return 'trudne';
  }

  Widget displayDifficulty(int index) {
    if (recipesForToday[index].difficulty == 1) {
      return Row(
        children: <Widget>[
          SizedBox(width: 5.0),
          ImageIcon(
            AssetImage('assets/chef.png'),
            size: 25,
            color: Colors.red[600],
          ),
        ],
      );
    }
    if (recipesForToday[index].difficulty == 2) {
      return Row(
        children: <Widget>[
          SizedBox(width: 5.0),
          ImageIcon(
            AssetImage('assets/chef.png'),
            size: 25,
            color: Colors.red[600],
          ),
          SizedBox(width: 2.0),
          ImageIcon(
            AssetImage('assets/chef.png'),
            size: 25,
            color: Colors.red[600],
          ),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          SizedBox(width: 5.0),
          ImageIcon(
            AssetImage('assets/chef.png'),
            size: 25,
            color: Colors.red[600],
          ),
          SizedBox(width: 2.0),
          ImageIcon(
            AssetImage('assets/chef.png'),
            size: 25,
            color: Colors.red[600],
          ),
          SizedBox(width: 2.0),
          ImageIcon(
            AssetImage('assets/chef.png'),
            size: 25,
            color: Colors.red[600],
          ),
        ],
      );
    }
  }

  void randomRecipesForDay() {
    List<Recipe> results = [];
    while (results.length < 3) {
      var randomRecipe = randomChoice(recipes);
      if (!results.contains(randomRecipe)) {
        results.add(randomRecipe);
      }
    }
    setState(() {
      recipesForToday = results;
    });
  }
}
