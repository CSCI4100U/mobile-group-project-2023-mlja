import 'package:flutter/material.dart';
import 'package:life_balance_plus/view/widgets/custom_tabbar.dart';
import '../../../data/model/meal.dart';
import '../../../data/model/diet.dart';
import '../../../control/meals_control.dart';
import '../../../control/diets_control.dart';
import 'meals_data_table.dart';
import 'create_diet_form.dart';
import 'diet_dashboard.dart';

class DietPage extends StatefulWidget {
  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  List<Meal> meals = [];
  late Diet sampleDiet;

  Future<void> _loadMeals() async {
    final meals_ = await MealControl().getAllMeals();
    setState(() {
      meals = meals_;
    });
  }

  @override
  void initState() {
    super.initState();
    DietControl().addDummyData();
    _loadMeals();
    sampleDiet = Diet(
      dailyCals: 10,
      dietType: DietType.other,
      startDate: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomTabbar(
      pages: [
        Center(child: DietDashboard()),
        Center(child: MealsDataTable(meals: meals)),
        Center(child: CreateDietForm()),
      ],
      tabNames: const ['Dashboard', 'Log', 'Create'],
    );
  }
}
