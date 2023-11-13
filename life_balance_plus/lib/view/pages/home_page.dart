import 'package:flutter/material.dart';
import 'package:life_balance_plus/view/widgets/home_nutrition_card.dart';
import 'package:life_balance_plus/view/widgets/home_summary_card.dart';
import 'package:life_balance_plus/view/widgets/home_workout_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                      name: 'John Doe',
                      date: DateTime.now(),
                      caloriesEaten: 2000,
                      caloriesBurned: 500,
                      milesRan: 2.5,
                      litersDrank: 1.5,
                    ),
                    const SizedBox(height: 16),
                    const HomeNutritionCard(),
                    const SizedBox(height: 16),
                    const HomeWorkoutCard(workoutName: 'Upper Split'),
                    const SizedBox(height: 16),
                    const Card(
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(100),
                        child: Center(
                          child: Text('Run Bar Chart'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Card(
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(100),
                        child: Center(
                          child: Text('Calories Line Graph'),
                        ),
                      ),
                    ),
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
