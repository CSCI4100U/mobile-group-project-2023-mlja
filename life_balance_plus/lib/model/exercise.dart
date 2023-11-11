class Exercise {
  int? id;
  String name;
  int? sets;

  Exercise({this.id, required this.name, this.sets});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sets': sets,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      sets: map['sets'],
    );
  }

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, sets: $sets)';
  }
}