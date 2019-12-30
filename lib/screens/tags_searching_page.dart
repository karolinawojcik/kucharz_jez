import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kucharz_jez/models/recipe.dart';
import 'package:kucharz_jez/models/user.dart';
import 'package:kucharz_jez/screens/results_page.dart';

class TagsSearchingPage extends StatefulWidget {
  final AppUser user;

  const TagsSearchingPage({Key key, this.user}) : super(key: key);
  @override
  _TagsSearchingPageState createState() => _TagsSearchingPageState();
}

class _TagsSearchingPageState extends State<TagsSearchingPage> {
  List<String> _tags = [];
  List<String> _filteredTags = [];
  var _searchView = new TextEditingController();
  bool _firstSearch = true;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _tags = [
      'obiady',
      'śniadania',
      'kolacje',
      'przystawki',
      'desery',
      'ciasta',
      'napoje',
      'sałatki',
      'surówki',
      'wegańskie',
      'wegetariańskie',
      'makarony',
      'zupy',
      'przekąski',
      'świąteczne',
      'pieczywo',
      'przetwory',
      'dania z jaj',
      'mięsa',
      'na zimno',
      'dania mączne',
      'kurczak',
      'ryż',
    ];
    _tags.sort();
  }

  _TagsSearchingPageState(){
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

  Widget printList(){
    return _firstSearch ? _createListView() : _performListView();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
      ),
    );
  }

  Widget _performListView() {
    _filteredTags = new List<String>();
    for (int i = 0; i < _tags.length; i++) {
      var item = _tags[i];

      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filteredTags.add(item);
      }
    }
    return _createFilteredListView();
  }

  Widget _createListView() {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _tags.length,
              itemBuilder: (context, index) => Column(
                children: <Widget>[
                  new ListTile(
                    onTap: () {
                      _searchForRecipesWithTag(_tags[index]);
                    },
                    title: Column(
                      children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                                  child: Text(
                                    _tags[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black87,
                                      fontFamily: 'OpenSans',
                                      fontSize: 18,
                                    ),
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

  Widget _createFilteredListView() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _filteredTags.length,
      itemBuilder: (context, index) => Column(
        children: <Widget>[
          new ListTile(
            onTap: () {
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => DishPage(recipeId: index)));
              _searchForRecipesWithTag(_filteredTags[index]);
            },
            title: Column(
              children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0),
                          child: Text(
                            _filteredTags[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black87,
                              fontFamily: 'OpenSans',
                              fontSize: 18,
                            ),
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
  Future<void> _searchForRecipesWithTag(String tag) async {
    List<Recipe> recipes = [];
    List<Recipe> results = [];
    QuerySnapshot querySnapshot = await Firestore.instance.collection('recipes').getDocuments();
    var list = querySnapshot.documents;
    for(var f in list){
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
    for(var recipe in recipes){
      var types = recipe.types;
      for(var type in types){
        if(type == tag){
          results.add(recipe);
          break;
        }
      }
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultsPage(recipes: results, user: widget.user, message: tag)));
  }
}
