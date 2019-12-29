import 'package:flutter/material.dart';
import 'package:kucharz_jez/screens/names_searching_page.dart';
import 'package:kucharz_jez/screens/tags_searching_page.dart';

class RecipesPage extends StatefulWidget {
  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  String dropdownValue = 'nazwa';
  Widget actualResultList = new NamesSearchingPage();
  Widget resultList = new NamesSearchingPage();

  @override
  void initState() {
    super.initState();
    resultList = actualResultList;
  }
  void refresh() {
    setState(() {
      resultList = actualResultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                    actualResultList = (newValue == 'nazwa' ? new NamesSearchingPage() : new TagsSearchingPage());
                    refresh();
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
            resultList,
          ],
        ),
      ),
    );
  }
}
