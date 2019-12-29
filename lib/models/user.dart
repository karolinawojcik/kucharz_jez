class AppUser{
  final String id;
  final String email;
  String userName;
  List<String> favoriteRecipes = [];
  List<String> shoppingList = [];

  AppUser(String id, String email)
      : this.id = id,
        this.email = email;

}