// import 'package:flutter/material.dart';
// import 'package:life_balance_plus/control/workouts_control.dart';
// import 'package:life_balance_plus/data/model/exercise.dart';
// import 'package:life_balance_plus/data/model/workout_plan.dart';
// import 'package:life_balance_plus/view/widgets/workout_dashboard_history_card.dart';
// 
// class DashboardHistory extends StatefulWidget {
//   const DashboardHistory({super.key});
// 
//   @override
//   State<DashboardHistory> createState() => _DashboardHistoryState();
// }
// 
// class _DashboardHistoryState extends State<DashboardHistory> {
//   late Future<List<WorkoutSession>> workoutSessionsFuture;
// 
//   Future<List<WorkoutSession>> queryWorkoutSessions() async {
//     return await WorkoutControl().getWorkoutSessions();
//   }
// 
//   void printWorkoutSessions() async {
//     List<WorkoutSession> workoutSessions =
//         await WorkoutControl().getWorkoutSessions();
//     workoutSessions.forEach((element) {
//       print(element);
//     });
//   }
// 
//   @override
//   void initState() {
//     super.initState();
//     workoutSessionsFuture = queryWorkoutSessions();
//     printWorkoutSessions();
//   }
// 
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: workoutSessionsFuture,
//       builder: (context, AsyncSnapshot<List<WorkoutSession>> snapshot) {
//         if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//           // Create a list of pairs (WorkoutSession, ExerciseSet)
//           List<MapEntry<WorkoutSession, ExerciseSet>> allExercises = snapshot
//               .data!
//               .expand((session) => session.exercises
//                   .map((exercise) => MapEntry(session, exercise)))
//               .toList();
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: ListView.builder(
//               itemCount: allExercises.length,
//               itemBuilder: (context, index) {
//                 // Create a map pair where the key is the WorkoutSession and the value is the ExerciseSet
//                 MapEntry<WorkoutSession, ExerciseSet> pair =
//                     allExercises[index];
//                 return WorkoutDashboardHistoryCard(
//                   title: pair.value.name,
//                   date: pair.key.date,
//                   exerciseSet: pair.value,
//                 );
//               },
//             ),
//           );
//         } else if (snapshot.hasData && snapshot.data!.isEmpty) {
//           return const Center(
//             child: Text('No workouts found'),
//           );
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return const CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }


// Copied old page since backend completely changed
import 'package:flutter/material.dart';
import 'package:life_balance_plus/view/widgets/workout_dashboard_history_card.dart';

class DashboardHistory extends StatelessWidget {
  const DashboardHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Workout History',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 26),
            WorkoutDashboardHistoryCard(
              title: 'Back Day',
              date: DateTime(2023, 9, 21),
            ),
            const SizedBox(height: 16),
            WorkoutDashboardHistoryCard(
              title: 'Chest Day',
              date: DateTime(2023, 9, 12),
            ),
          ],
        ),
      ),
    );
  }
}
