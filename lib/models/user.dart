import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String email;
  String userName;
  List<dynamic> favoriteRecipes = [];
  List<dynamic> shoppingList = [];

  AppUser(String id, String email)
      : this.id = id,
        this.email = email;


  Future<void> updateData() async {
    await Firestore.instance.collection('/users').document(this.id).updateData({
      'favorite_recipes': this.favoriteRecipes,
      'shopping_list': this.shoppingList
    });
  }
}
