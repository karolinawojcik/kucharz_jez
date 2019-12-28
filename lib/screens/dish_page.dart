import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DishPage extends StatefulWidget {
  final int recipeId;

  const DishPage({Key key, this.recipeId}) : super(key: key);

  @override
  _DishPageState createState() => _DishPageState();
}

class _DishPageState extends State<DishPage>{
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
                  return const Text(
                    'Loading',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'OpenSans',
                      color: Colors.black87,
                    ),
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
                    Text(
                      snapshot.data.documents[widget.recipeId]['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontFamily: 'AmaticSC',
                        fontSize: 45,
                      ),
                    ),
                    Divider(color: Colors.black87),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        snapshot
                            .data.documents[widget.recipeId]['types'].length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text(
                              snapshot.data.documents[widget.recipeId]['types']
                                  [index],
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                                fontFamily: 'OpenSans',
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          );
                        },
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
                                          onPressed: () {},
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
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.favorite_border, color: Colors.white),
        backgroundColor: Colors.red[600],
      ),
    );
  }
}
