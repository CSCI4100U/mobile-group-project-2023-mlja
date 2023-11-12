import 'package:flutter/material.dart';

class HomeSummaryCard extends StatelessWidget {
  final String name;
  final DateTime date;
  final int caloriesEaten;
  final int caloriesBurned;
  final double milesRan;
  final double litersDrank;

  const HomeSummaryCard({
    super.key,
    required this.name,
    required this.date,
    required this.caloriesEaten,
    required this.caloriesBurned,
    required this.milesRan,
    required this.litersDrank,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle metricTextStyle =
        Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w900,
            );
    TextStyle metricLabelStyle =
        Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.black54);
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.black,
                    radius: 26,
                    child: Icon(Icons.person)),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                    ),
                    const Text(
                      'Hello!',
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                const Text('Today'),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  child: Text(date.day.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(caloriesEaten.toString(), style: metricTextStyle),
                    Text('Calories Eaten', style: metricLabelStyle),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      caloriesBurned.toString(),
                      style: metricTextStyle,
                    ),
                    Text('Calories Burned', style: metricLabelStyle),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      milesRan.toString(),
                      style: metricTextStyle,
                    ),
                    Text('Miles Ran', style: metricLabelStyle),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      litersDrank.toString(),
                      style: metricTextStyle,
                    ),
                    Text('Liters Drank', style: metricLabelStyle),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  label: const Text('Share'),
                  icon: const Icon(Icons.share),
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () {},
                ),
                const SizedBox(width: 16),
                TextButton.icon(
                  label: const Text('Edit'),
                  icon: const Icon(Icons.edit),
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
