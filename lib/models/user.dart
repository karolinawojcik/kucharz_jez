import 'package:kucharz_jez/models/recipe.dart';

class User{
  final int id;
  final String userName;
  List<Recipe> favoriteRecipes = [];
  List<String> shoppingList = [];

  User(int id, String userName)
      : this.id = id,
  this.userName = userName;

}