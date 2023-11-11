import 'package:flutter/material.dart';
import '../model/meal.dart';
import '../control/meals_control.dart';


class DietPage extends StatefulWidget {
  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {

  List<Meal> meals = [];

  Future<void> _loadMeals() async {
    final meals_ = await MealControl().getAllMeals();
    setState(() {
      meals = meals_;
    });
  }

  @override
  void initState() {
    super.initState();
    // Uncomment this the first time you run to add some meals to the local db
    // MealControl().addDummyData();
    _loadMeals();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            final meal = meals[index];
            return ListTile(
              title: Text('${meal.name} - Type: ${meal.mealType}'),
              subtitle: Text(
                  'Macros - Fats: ${meal.fats}, Proteins: ${meal.proteins}, Carbs: ${meal.carbs}'
              )
            );
          },
        )
      ),
    );
  }
}
