import 'package:flutter/material.dart';
import 'package:life_balance_plus/view/widgets/custom_tabbar.dart';
import '../../../data/model/meal.dart';
import '../../../control/meals_control.dart';
import 'meals_data_table.dart';

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
    MealControl().addDummyData();
    _loadMeals();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTabbar(
      pages: [
        Placeholder(),
        Center(child: MealsDataTable(meals: meals)),
        Placeholder(),
      ],
      tabNames: const ['Dashboard', 'Log', 'Create'],
    );
  }
}