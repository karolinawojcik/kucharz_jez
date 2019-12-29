import 'package:flutter/material.dart';
import 'package:kucharz_jez/models/recipe.dart';
import 'package:kucharz_jez/screens/dish_page.dart';

class ResultsPage extends StatefulWidget {
  final List<Recipe> recipes;

  const ResultsPage({Key key, this.recipes}) : super(key: key);
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {

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
            printList(),
          ],
        ),
      ),
    );
  }
  Widget printList() {
    if(widget.recipes.length == 0){
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Brak wyników',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black87,
              fontFamily: 'OpenSans',
              fontStyle: FontStyle.italic,
              fontSize: 30,
            ),
          ),
        ),
      );
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.recipes.length,
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
                        widget.recipes[index].imageUrl,
                        width: 80.0,
                        height: 80.0,
                      ),
                    ),
                    Text(
                      widget.recipes[index].name,
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
