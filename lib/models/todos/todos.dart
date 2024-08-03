class Todos {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  Todos(this.userId, this.id, this.title, this.completed);

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  factory Todos.fromJson(Map<String, dynamic> json) {
    return Todos(
      json['userId'],
      json['id'],
      json['title'],
      json['completed'],
    );
  }

  Todos copyWith({
    int? userId,
    int? id,
    String? title,
    bool? completed,
  }) {
    return Todos(
      userId ?? this.userId,
      id ?? this.id,
      title ?? this.title,
      completed ?? this.completed,
    );
  }
}
