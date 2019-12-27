import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kucharz_jez/screens/dish_page.dart';

class RecipesPage extends StatefulWidget {
  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  String dropdownValue = 'nazwa';

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
                            onTap: () {},
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
                                    builder: (context) => DishPage(recipeId: index)));
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
                }),
          ],
        ),
      ),
    );
  }
}
