import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kucharz_jez/models/recipe.dart';
import 'package:kucharz_jez/screens/dish_page.dart';

class RecipesPage extends StatefulWidget {
  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
//  Future _doneFuture;
  String dropdownValue = 'nazwa';
  final databaseReference = Firestore.instance;
  List<Recipe> _recipes = [];
  List<Recipe> _filteredRecipes = [];
  var suggestions = new ListView();
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = '';

  @override
  void initState() {
    super.initState();
//    initRecipes();
//    suggestions = DataSearch(_recipes).buildSuggestions(context);
  }

  _RecipesPageState(){
//    _doneFuture = initRecipes();
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        setState(() {
          _firstSearch = true;
          _query = '';
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }
//  Future get initializationDone => _doneFuture;

  void addRecipe(Recipe rec){
    _recipes.add(rec);
  }

  Future<void> initRecipes() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection('recipes').getDocuments();
    var list = querySnapshot.documents;
    for(var f in list){
      addRecipe(Recipe(
          int.parse(f.documentID),
          f['name'],
          f['image_url'],
          f['ingredients'],
          f['instruction'],
          f['types'],
          f['difficulty'],
          f['time']));
    }
//    databaseReference
//        .collection("recipes")
//        .getDocuments()
//        .then((QuerySnapshot snapshot) {
//      snapshot.documents.forEach((f) => addRecipe(Recipe(
//          int.parse(f.documentID),
//          f['name'],
//          f['image_url'],
//          f['ingredients'],
//          f['instruction'],
//          f['types'],
//          f['difficulty'],
//          f['time'])));
//    });
  }
//  void waitForInitialization() async {
//    await initializationDone;
//  }
  Widget printList(){
    return _firstSearch ? _createListView() : _performListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              height: 45.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(22.0)),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                        controller: _searchview,
//                        onEditingComplete: () {
//                          suggestions =
//                              DataSearch(_recipes).buildSuggestions(context);
//                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Szukaj w przepisach',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black87,
                            fontFamily: 'OpenSans',
                          ),
                          icon: GestureDetector(
                            child: Icon(Icons.search, color: Colors.black87),
//                            onTap: () {
//                              suggestions = DataSearch(_recipes)
//                                  .buildSuggestions(context);
//                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Wyszukiwanie według: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.black87,
                    fontFamily: 'OpenSans',
                    fontSize: 16,
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 20,
                  elevation: 16,
                  underline: Container(
                    height: 1,
                    color: Colors.black87,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['nazwa', 'tagi']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black87,
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            printList(),
//            StreamBuilder(
//                stream: Firestore.instance.collection('recipes').snapshots(),
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
//                    scrollDirection: Axis.vertical,
//                    shrinkWrap: true,
//                    itemCount: snapshot.data.documents.length,
//                    itemBuilder: (context, index) => Column(
//                      children: <Widget>[
//                        new ListTile(
//                          onTap: () {
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (context) =>
//                                        DishPage(recipeId: index)));
//                          },
//                          title: Column(
//                            children: <Widget>[
//                              Row(
//                                children: <Widget>[
//                                  Padding(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 10.0),
//                                    child: Image.network(
//                                      snapshot.data.documents[index]
//                                          ['image_url'],
//                                      width: 80.0,
//                                      height: 80.0,
//                                    ),
//                                  ),
//                                  Text(
//                                    snapshot.data.documents[index]['name'],
//                                    style: TextStyle(
//                                      fontWeight: FontWeight.w300,
//                                      color: Colors.black87,
//                                      fontFamily: 'OpenSans',
//                                      fontSize: 18,
//                                    ),
//                                  ),
//                                ],
//                              ),
//                              Divider(color: Colors.black87),
//                            ],
//                          ),
//                        ),
//                      ],
//                    ),
//                  );
//                }),
          ],
        ),
      ),
    );
  }

  Widget _performListView() {
    _filteredRecipes = new List<Recipe>();
    for (int i = 0; i < _recipes.length; i++) {
      var item = _recipes[i];

      if (item.name.toLowerCase().contains(_query.toLowerCase())) {
        _filteredRecipes.add(item);
      }
    }
    return _createFilteredListView();
  }

  Widget _createListView() {
    return StreamBuilder(
                stream: Firestore.instance.collection('recipes').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return const Text(
                      'Loading',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'OpenSans',
                        color: Colors.black87,
                      ),
                    );
                  else{
                    if(_recipes.length == 0){
                    var list = snapshot.data.documents;
                   for(var f in list){
                      addRecipe(new Recipe(
                          int.parse(f.documentID),
                          f['name'],
                          f['image_url'],
                          f['ingredients'],
                          f['instruction'],
                          f['types'],
                          f['difficulty'],
                          f['time']));
                   }}
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) => Column(
                      children: <Widget>[
                        new ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DishPage(recipeId: index)));
                          },
                          title: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Image.network(
                                      snapshot.data.documents[index]
                                          ['image_url'],
                                      width: 80.0,
                                      height: 80.0,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data.documents[index]['name'],
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
                  );
                }});
  }

  Widget _createFilteredListView() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _filteredRecipes.length,
      itemBuilder: (context, index) => Column(
        children: <Widget>[
          new ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DishPage(recipeId: index)));
            },
            title: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Image.network(
                        _filteredRecipes[index].imageUrl,
                        width: 80.0,
                        height: 80.0,
                      ),
                    ),
                    Text(
                      _filteredRecipes[index].name,
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
    );
  }
}

//class DataSearch extends SearchDelegate<String> {
//  final recipes;
//
//  DataSearch(this.recipes);
//
//  @override
//  List<Widget> buildActions(BuildContext context) {
//    return [
//      IconButton(
//        icon: Icon(Icons.clear),
//        onPressed: () {},
//      )
//    ];
//  }
//
//  @override
//  Widget buildLeading(BuildContext context) {
//    // TODO: implement buildLeading
//    return null;
//  }
//
//  @override
//  Widget buildResults(BuildContext context) {
//    // TODO: implement buildResults
//    return null;
//  }
//
//  @override
//  Widget buildSuggestions(BuildContext context) {
//    final suggestionsList = query.isEmpty
//        ? recipes
//        : recipes.where((p) => p.name.startsWith(query)).toList();
//
//    return ListView.builder(
//      scrollDirection: Axis.vertical,
//      shrinkWrap: true,
//      itemCount: suggestionsList.length,
//      itemBuilder: (context, index) => Column(
//        children: <Widget>[
//          new ListTile(
//            onTap: () {
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => DishPage(recipeId: index)));
//            },
//            title: Column(
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                      child: Image.network(
//                        suggestionsList[index].imageUrl,
//                        width: 80.0,
//                        height: 80.0,
//                      ),
//                    ),
//                    Text(
//                      suggestionsList[index].name,
//                      style: TextStyle(
//                        fontWeight: FontWeight.w300,
//                        color: Colors.black87,
//                        fontFamily: 'OpenSans',
//                        fontSize: 18,
//                      ),
//                    ),
//                  ],
//                ),
//                Divider(color: Colors.black87),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
