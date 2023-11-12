import 'package:flutter/material.dart';

class HomeNutritionCard extends StatelessWidget {
  const HomeNutritionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Track Nutrition',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    label: Text('Log Meal',
                        style: Theme.of(context).textTheme.labelMedium),
                    icon: const Icon(Icons.keyboard_double_arrow_right),
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(60, 158, 158, 158),
                        ),
                        child: const Icon(Icons.free_breakfast)),
                    const SizedBox(height: 8),
                    const Text('Breakfast'),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(60, 158, 158, 158),
                        ),
                        child: const Icon(Icons.lunch_dining)),
                    const SizedBox(height: 8),
                    const Text('Lunch'),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(60, 158, 158, 158),
                        ),
                        child: const Icon(Icons.dinner_dining)),
                    const SizedBox(height: 8),
                    const Text('Dinner'),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(60, 158, 158, 158),
                        ),
                        child: const Icon(Icons.local_dining)),
                    const SizedBox(height: 8),
                    const Text('Snacks'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
