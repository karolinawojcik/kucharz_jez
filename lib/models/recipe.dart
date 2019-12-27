class Recipe {
  final int id;
  final List<String> ingredients;
  final List<String> instruction;
  final String name;
  final int difficulty;
  final String image_url;
  final int time;
  final List<String> types;

  Recipe(
      int id,
      List<String> ingredients,
      List<String> instruction,
      String name,
      int difficulty,
      String image_url,
      int time,
      List<String> types)
      : this.id = id,
        this.ingredients = ingredients,
        this.instruction = instruction,
        this.name = name,
        this.difficulty = difficulty,
        this.image_url = image_url,
        this.time = time,
        this.types = types;

  Recipe.fromMap(Map<String, dynamic> data, int id)
      : this(
            id,
            new List<String>.from(data['ingredients']),
            new List<String>.from(data['instruction']),
            data['name'],
            data['difficulty'],
            data['image_url'],
            data['time'],
            data['types']);
}
