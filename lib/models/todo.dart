class TodoModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['is_completed'] == 1,
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
