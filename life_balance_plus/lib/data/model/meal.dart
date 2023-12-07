class Meal {
  int? id;
  int? dietId;
  String? firestoreId;
  String name;
  String mealType;
  double? fats;
  double? proteins;
  double? carbs;

  Meal({
    this.id,
    this.dietId,
    this.firestoreId,
    required this.name,
    required this.mealType,
    this.fats,
    this.proteins,
    this.carbs,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dietId': dietId,
      'firestoreId': firestoreId,
      'name': name,
      'mealType': mealType,
      'fats': fats,
      'proteins': proteins,
      'carbs': carbs,
    }..removeWhere(
          (dynamic key, dynamic value) => value == null);
  }

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      dietId: map['dietId'],
      firestoreId: map['firestoreId'],
      name: map['name'] as String,
      mealType: map['mealType'] as String,
      fats: map['fats'],
      proteins: map['proteins'],
      carbs: map['carbs'],
    );
  }

  @override
  String toString() {
    return 'Meal(id: $id, name: $name, mealType: $mealType, Macros: ($fats, $proteins, $carbs}))';
  }
}
