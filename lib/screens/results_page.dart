import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kucharz_jez/models/recipe.dart';
import 'package:kucharz_jez/models/user.dart';
import 'package:kucharz_jez/screens/dish_page.dart';

class ResultsPage extends StatefulWidget {
  final AppUser user;
  final List<Recipe> recipes;
  final String message;

  const ResultsPage({Key key, this.recipes, this.user, this.message})
      : super(key: key);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.green,
      ),
    );
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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.message,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'AmaticSC',
                  ),
                ),
              ),
            ),
            printList(),
          ],
        ),
      ),
    );
  }

  Widget printList() {
    if (widget.recipes.length == 0) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            'Brak wyników',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black87,
              fontFamily: 'AmaticSC',
              fontSize: 36,
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
                      builder: (context) => DishPage(
                          recipeId: widget.recipes[index].id,
                          user: widget.user)));
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
                    Flexible(
                      child: Text(
                        widget.recipes[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black87,
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                        ),
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
