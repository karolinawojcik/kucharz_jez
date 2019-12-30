import 'package:flutter/material.dart';
import 'package:kucharz_jez/models/user.dart';

class ShoppingListPage extends StatefulWidget {
  final AppUser user;

  const ShoppingListPage({Key key, this.user}) : super(key: key);

  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<dynamic> actualList;

  @override
  void initState() {
    actualList = widget.user.shoppingList;
    super.initState();
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
            Text(
              'Lista zakupów:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontFamily: 'Kalam',
                fontSize: 36,
              ),
            ),
            printList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          removeAllFromList();
        },
        child: Icon(Icons.clear, color: Colors.white),
        backgroundColor: Colors.red[600],
      ),
    );
  }

  Widget printList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: actualList.length,
      itemBuilder: (context, index) => Column(
        children: <Widget>[
          new ListTile(
            title: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: IconButton(
                            onPressed: () {
                              removeFromList(index);
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.red[600],
                            ))),
                    Text(
                      '- ' + actualList[index].toString() + ',',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                        fontFamily: 'Kalam',
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void removeFromList(int index) {
    widget.user.shoppingList.removeAt(index);
    setState(() {
      actualList = widget.user.shoppingList;
    });
  }

  void removeAllFromList() {
    widget.user.shoppingList.clear();
    setState(() {
      actualList = widget.user.shoppingList;
    });
  }
}
