class AppUser{
  final String id;
  final String email;
  String userName;
  List<dynamic> favoriteRecipes = [];
  List<dynamic> shoppingList = [];

  AppUser(String id, String email)
      : this.id = id,
        this.email = email;

}