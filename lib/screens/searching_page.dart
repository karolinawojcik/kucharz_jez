import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kucharz_jez/models/recipe.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:kucharz_jez/models/user.dart';
import 'package:kucharz_jez/screens/results_page.dart';

class SearchingPage extends StatefulWidget {
  final AppUser user;

  const SearchingPage({Key key, this.user}) : super(key: key);
  @override
  _SearchingPageState createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  List<String> ingredients = [];
  List<String> actualIngredients = [];
  List<String> existingIngredients = [];
  List<Recipe> recipes = [];
  var _searchView = new TextEditingController();
  var emptyQuery = '';
  bool isLoading = true;

  @override
  void initState() {
    getAllIngredients();
    actualIngredients = [];
    ingredients = actualIngredients;
    super.initState();
  }

  Future<void> getAllIngredients() async {
    List<String> results = [];
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
    for (var recipe in recipes) {
      var ingredients = recipe.ingredients;
      for (var ingredient in ingredients) {
        if (!results.contains(ingredient['name'])) {
          results.add(ingredient['name']);
        }
      }
    }
    results.sort();
    existingIngredients = results;
    setState(() {
      isLoading = false;
    });
  }

  void refresh() async {
    setState(() {
      ingredients = actualIngredients;
      _searchView.text = emptyQuery;
    });
  }

  Widget row(String item) {
    return SingleChildScrollView(
      child: Row(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            child: Icon(Icons.add,
                color: Colors.black87),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            item,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black87,
              fontFamily: 'OpenSans',
              fontSize: 18,
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                'Co masz w lodówce?',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'AmaticSC',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(22.0)),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: <Widget>[
                          isLoading
                              ? Center(child:CircularProgressIndicator(),)
                              : SingleChildScrollView(
                            child: AutoCompleteTextField<String>(
                                    suggestions: existingIngredients,
                                    controller: _searchView,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Wpisz nazwę produktu',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black87,
                                        fontFamily: 'OpenSans',
                                        fontSize: 16,
                                      ),
                                      icon: GestureDetector(
                                        child: Icon(Icons.add,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    itemFilter: (item, query) {
                                      return item
                                          .toLowerCase()
                                          .startsWith(query.toLowerCase());
                                    },
                                    itemSorter: (a, b) {
                                      return a.compareTo(b);
                                    },
                                    itemSubmitted: (item) {
                                      addToIngredients(item);
                                    },
                                    itemBuilder: (context, item) {
                                      return row(item);
                                    }),
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: ingredients.length,
              itemBuilder: (context, index) => Column(
                children: <Widget>[
                  new ListTile(
                    onTap: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => DishPage(recipeId: index)));
                    },
                    title: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: IconButton(
                                    onPressed: () {
                                      removeFromIngredients(index);
                                    },
                                    icon: Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.red[600],
                                    ))),
                            Text(
                              ingredients[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black87,
                                fontFamily: 'OpenSans',
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.black87),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          searchForRecipes();
        },
        child: Icon(Icons.search, color: Colors.white),
        backgroundColor: Colors.red[600],
      ),
    );
  }

  void removeFromIngredients(int index) {
    actualIngredients.removeAt(index);
    refresh();
  }

  void addToIngredients(String item) {
    if (!actualIngredients.contains(item)) actualIngredients.add(item);
    refresh();
  }

  void searchForRecipes(){
    List<Recipe> results = [];
    for(var recipe in recipes){
      bool containsAll = true;
      List<String> recipeIngredients = [];
      for(var i in recipe.ingredients){
        recipeIngredients.add(i['name']);
      }
      for(var ingredient in recipeIngredients){
        if(!ingredients.contains(ingredient)){
          containsAll = false;
          break;
        }
      }
      if(containsAll){
        results.add(recipe);
      }
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultsPage(recipes: results, user: widget.user)));
  }
}
