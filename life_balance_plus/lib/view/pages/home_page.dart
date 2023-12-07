import 'package:flutter/material.dart';
import 'package:life_balance_plus/view/widgets/home_nutrition_card.dart';
import 'package:life_balance_plus/view/widgets/home_summary_card.dart';
import 'package:life_balance_plus/view/widgets/home_workout_card.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/data/model/session.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:life_balance_plus/view/widgets/home_run_card.dart';
import 'package:life_balance_plus/view/widgets/home_calories_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Account? account = Session.instance.account;
    String name = account != null ? '${account.firstName}' : 'John Doe';

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 280,
            width: double.infinity,
            child: CustomPaint(
              painter: CurvePainter(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 90,
                ),
                child: Column(
                  children: [
                    HomeSummaryCard(
                      name: name,
                      date: DateTime.now(),
                      caloriesEaten: account?.caloricIntakeGoal ?? 0,
                      caloriesBurned: account?.dailyActivityGoal ?? 0,
                      milesRan: 2.5, // TODO: Retrieve data from db
                      litersDrank: account!.waterIntakeGoal.toDouble(),
                    ),
                    const SizedBox(height: 16),
                    const HomeNutritionCard(),
                    const SizedBox(height: 16),
                    const HomeWorkoutCard(workoutName: 'Upper Split'),
                    const SizedBox(height: 16),
                    const HomeRunCard(), // Add the HomeRunCard
                    const SizedBox(height: 16),
                    const HomeCaloriesCard(), // Add the HomeCaloriesCard
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, size.height * 0.5)
      ..quadraticBezierTo(
          size.width / 2, size.height * 0.95, size.width, size.height * 0.5)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
