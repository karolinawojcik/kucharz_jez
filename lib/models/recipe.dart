class Recipe {
  final int id;
  final String name;
  final String imageUrl;
  final List<dynamic> ingredients;
  final List<dynamic> instruction;
  final List<dynamic> types;
  final int difficulty;
  final int time;

  Recipe(int id, String name, String imageUrl, List<dynamic> ingredients,
      List<dynamic> instruction, List<dynamic> types, int difficulty, int time)
      : this.id = id,
        this.name = name,
        this.imageUrl = imageUrl,
        this.ingredients = ingredients,
        this.instruction = instruction,
        this.types = types,
        this.difficulty = difficulty,
        this.time = time;
}
