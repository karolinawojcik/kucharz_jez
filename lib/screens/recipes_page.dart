import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kucharz_jez/models/user.dart';
import 'package:kucharz_jez/screens/names_searching_page.dart';
import 'package:kucharz_jez/screens/tags_searching_page.dart';

class RecipesPage extends StatefulWidget {
  final AppUser user;

  const RecipesPage({Key key, this.user}) : super(key: key);

  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  String dropdownValue = 'nazwa';
  Widget actualResultList;
  Widget resultList;

  @override
  void initState() {
    super.initState();
    actualResultList = new NamesSearchingPage(user: widget.user);
    resultList = actualResultList;
  }

  void refresh() {
    setState(() {
      resultList = actualResultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.green,
      ),
    );
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
                    actualResultList = (newValue == 'nazwa'
                        ? new NamesSearchingPage(user: widget.user)
                        : new TagsSearchingPage(user: widget.user));
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
