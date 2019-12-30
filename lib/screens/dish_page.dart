import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kucharz_jez/models/user.dart';

class DishPage extends StatefulWidget {
  final int recipeId;
  final AppUser user;

  const DishPage({Key key, this.recipeId, this.user}) : super(key: key);

  @override
  _DishPageState createState() => _DishPageState();
}

class _DishPageState extends State<DishPage> {
  @override
  void initState() {
    inFavorites = isInFavorites(widget.recipeId.toString());
    super.initState();
  }

  bool inFavorites;

  String difficultyString(int difficulty) {
    if (difficulty == 1) return 'łatwe';
    if (difficulty == 2) return 'średnie';
    if (difficulty == 3) return 'trudne';
    return 'nieznany';
  }

  String amountString(num amount) {
    if (amount == 0) return '';
    return amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance.collection('recipes').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Image.network(
                        snapshot.data.documents[widget.recipeId]['image_url'],
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        snapshot.data.documents[widget.recipeId]['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontFamily: 'AmaticSC',
                          fontSize: 45,
                        ),
                      ),
                    ),
                    Divider(color: Colors.black87),
                    Container(
                      height: (snapshot.data.documents[widget.recipeId]['types']
                                      .length /
                                  3) *
                              65.0 +
                          40,
                      width: 420.0,
                      child: GridView.count(
                        childAspectRatio: 16.0 / 5.0,
                        primary: false,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        crossAxisCount: 3,
                        children: List.generate(
                          snapshot
                              .data.documents[widget.recipeId]['types'].length,
                          (index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.green[900],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22.0)),
                                border: Border.all(color: Colors.white),
                              ),
                              height: 25.0,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                    snapshot.data.documents[widget.recipeId]
                                        ['types'][index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontFamily: 'OpenSans',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Czas przygotowania: ' +
                            snapshot.data.documents[widget.recipeId]['time']
                                .toString() +
                            ' min',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black87,
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Stopień trudności: ' +
                            difficultyString(snapshot
                                .data.documents[widget.recipeId]['difficulty']),
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black87,
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Divider(color: Colors.black87),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Składniki:',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black87,
                          fontFamily: 'AmaticSC',
                          fontSize: 36,
                        ),
                      ),
                    ),
                    Divider(color: Colors.black87),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data
                          .documents[widget.recipeId]['ingredients'].length,
                      itemBuilder: (context, index) => Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          snapshot.data
                                                  .documents[widget.recipeId]
                                              ['ingredients'][index]['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black87,
                                            fontFamily: 'OpenSans',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          amountString(snapshot.data
                                                  .documents[widget.recipeId]
                                              ['ingredients'][index]['amount']),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black87,
                                            fontFamily: 'OpenSans',
                                            fontStyle: FontStyle.italic,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: Text(
                                          snapshot.data
                                                  .documents[widget.recipeId]
                                              ['ingredients'][index]['unit'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black87,
                                            fontFamily: 'OpenSans',
                                            fontStyle: FontStyle.italic,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: IconButton(
                                          onPressed: () {
                                            addToShoppingList(snapshot.data
                                                    .documents[widget.recipeId]
                                                ['ingredients'][index]['name']);
                                          },
                                          icon: Icon(
                                            Icons.add_shopping_cart,
                                            color: Colors.green[900],
                                            size: 25.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.black87),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Wykonanie:',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black87,
                          fontFamily: 'AmaticSC',
                          fontSize: 36,
                        ),
                      ),
                    ),
                    Divider(color: Colors.black87),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data
                          .documents[widget.recipeId]['instruction'].length,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 12.0),
                            child: Text(
                              'Krok ' +
                                  (index + 1).toString() +
                                  ':\n' +
                                  snapshot.data.documents[widget.recipeId]
                                      ['instruction'][index],
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black87,
                                fontFamily: 'OpenSans',
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'SMACZNEGO!',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black87,
                          fontFamily: 'AmaticSC',
                          fontSize: 36,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addToFavorite(widget.recipeId.toString());
        },
        child: Icon(inFavorites ? Icons.favorite : Icons.favorite_border,
            color: Colors.white),
        backgroundColor: Colors.red[600],
      ),
    );
  }

  void addToShoppingList(String item) {
    if (!widget.user.shoppingList.contains(item))
      widget.user.shoppingList.add(item);
  }

  void addToFavorite(String item) {
    if (!isInFavorites(item))
      widget.user.favoriteRecipes.add(item);
    else
      widget.user.favoriteRecipes.remove(item);

    setState(() {
      inFavorites = isInFavorites(item);
    });
  }

  bool isInFavorites(String item) {
    if (widget.user.favoriteRecipes.contains(item))
      return true;
    else
      return false;
  }
}
