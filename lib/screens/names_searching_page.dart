import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kucharz_jez/models/recipe.dart';
import 'package:kucharz_jez/models/user.dart';
import 'package:kucharz_jez/screens/dish_page.dart';

class NamesSearchingPage extends StatefulWidget {
  final AppUser user;

  const NamesSearchingPage({Key key, this.user}) : super(key: key);
  @override
  _NamesSearchingPageState createState() => _NamesSearchingPageState();
}

class _NamesSearchingPageState extends State<NamesSearchingPage> {
  List<Recipe> _recipes = [];
  List<Recipe> _filteredRecipes = [];
  var _searchView = new TextEditingController();
  bool _firstSearch = true;
  String _query = '';

  @override
  void initState() {
    super.initState();
  }

  _NamesSearchingPageState(){
    _searchView.addListener(() {
      if (_searchView.text.isEmpty) {
        setState(() {
          _firstSearch = true;
          _query = '';
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchView.text;
        });
      }
    });
  }

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
  }
  Widget printList(){
    return _firstSearch ? _createListView() : _performListView();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    controller: _searchView,
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
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        printList(),
      ]
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
              physics: NeverScrollableScrollPhysics(),
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
                                  DishPage(recipeId: index, user: widget.user)));
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
                            Flexible(
                              child: Text(
                                snapshot.data.documents[index]['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black87,
                                  fontFamily: 'OpenSans',
                                  fontSize: 18,
                                ),
                                //overflow: TextOverflow.clip,
                                maxLines: 3,
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
                      builder: (context) => DishPage(recipeId: _filteredRecipes[index].id, user: widget.user)));
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
                    Flexible(
                      child: Text(
                        _filteredRecipes[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black87,
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                        ),
                        //overflow: TextOverflow.ellipsis,
                        maxLines: 3,
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
