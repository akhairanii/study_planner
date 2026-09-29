class Activity {
  final String id;
  String title;
  String category; // "Pemrograman", "Matematika", "Bahasa Inggris", "Desain", "Basis Data"
  String description;
  bool isCompleted;
  bool isFavorite;

  Activity({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    this.isCompleted = false,
    this.isFavorite = false,
  });
}