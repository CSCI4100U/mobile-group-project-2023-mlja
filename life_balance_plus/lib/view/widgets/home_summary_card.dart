import 'package:flutter/material.dart';
import 'package:life_balance_plus/control/account_control.dart';
import 'package:life_balance_plus/data/model/account.dart';
import 'package:life_balance_plus/data/model/session.dart';

class HomeSummaryCard extends StatefulWidget {
  final String name;
  final DateTime date;
  final int caloriesEaten;
  final int caloriesBurned;
  final double milesRan;
  double litersDrank;

  HomeSummaryCard({
    super.key,
    required this.name,
    required this.date,
    required this.caloriesEaten,
    required this.caloriesBurned,
    required this.milesRan,
    required this.litersDrank,
  });

  @override
  State<HomeSummaryCard> createState() => _HomeSummaryCardState();
}

class _HomeSummaryCardState extends State<HomeSummaryCard> {
  Account? account = Session.instance.account;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final waterFieldController = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.black,
                        radius: 26,
                        child: Icon(Icons.person)),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                        ),
                        const Text(
                          'Hello!',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Row(
                  children: [
                    const Text('Today'),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      child: Text(widget.date.day.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(widget.caloriesEaten.toString(),
                        style: metricTextStyle),
                    Text('Calories Eaten', style: metricLabelStyle),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      widget.caloriesBurned.toString(),
                      style: metricTextStyle,
                    ),
                    Text('Calories Burned', style: metricLabelStyle),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      widget.milesRan.toString(),
                      style: metricTextStyle,
                    ),
                    Text('Miles Ran', style: metricLabelStyle),
                  ],
                ),
                InkWell(
                  onTap: () {
                    // Show a dialog to increment liters drank add and subtract buttons. Update account in db using AccountControl.updateAccount'
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Update Water Intake'),
                          content: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: waterFieldController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'Set Water Intake'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a value';
                                }
                                if (int.tryParse(value) == null) {
                                  return 'Please enter a valid number';
                                }
                                return null;
                              },
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Set'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  AccountControl.updateAccount(
                                      account!.copyWith(
                                    waterIntakeGoal:
                                        int.parse(waterFieldController.text),
                                  ));
                                  setState(() {
                                    widget.litersDrank =
                                        int.parse(waterFieldController.text)
                                            .toDouble();
                                  });
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        widget.litersDrank.toString(),
                        style: metricTextStyle,
                      ),
                      Text('Liters Drank', style: metricLabelStyle),
                    ],
                  ),
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
