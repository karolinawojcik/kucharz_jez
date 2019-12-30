import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:kucharz_jez/models/recipe.dart';
import 'package:dart_random_choice/dart_random_choice.dart';

class AppUser {
  final String id;
  final String email;
  String userName;
  List<dynamic> favoriteRecipes = [];
  List<dynamic> shoppingList = [];
  List<dynamic> recipesForToday = [];
  int timeOfLastGenerating = 0;

  AppUser(String id, String email)
      : this.id = id,
        this.email = email;

  Future<void> updateData() async {
    await Firestore.instance.collection('/users').document(this.id).updateData({
      'favorite_recipes': this.favoriteRecipes,
      'recipes_for_today': this.recipesForToday,
      'shopping_list': this.shoppingList,
      'time_of_last_generating': this.timeOfLastGenerating
    });
  }

  void randomRecipesForDay(List<Recipe> recipes) {
    if (this.timeOfLastGenerating != DateTime.now().day ||
        this.recipesForToday.length == 0) {
      List<dynamic> results = [];
      while (results.length < 3) {
        var randomRecipe = randomChoice(recipes);
        if (!results.contains(randomRecipe.id)) {
          results.add(randomRecipe.id);
        }
      }
      this.recipesForToday = results;
      this.timeOfLastGenerating = DateTime.now().day;
    }
  }
}
