import 'package:flutter/material.dart';
import '../../../data/model/diet.dart';
import 'package:life_balance_plus/control/diets_control.dart';

class CreateDietForm extends StatefulWidget {
  @override
  _CreateDietFormState createState() => _CreateDietFormState();
}

class _CreateDietFormState extends State<CreateDietForm> {
  final TextEditingController _caloriesController = TextEditingController();
  DietType _selectedDietType = DietType.other;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create a New Diet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _caloriesController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Daily Calories',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<DietType>(
            value: _selectedDietType,
            onChanged: (value) {
              setState(() {
                _selectedDietType = value!;
              });
            },
            items: DietType.values.map((type) {
              return DropdownMenuItem<DietType>(
                value: type,
                child: Text(type.toString().split('.').last),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Diet Type',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle form submission here
              _submitForm();
            },
            child: Text('Create Diet'),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    final String caloriesText = _caloriesController.text.trim();
    if (caloriesText.isEmpty) {
      return;
    }

    final int dailyCals = int.tryParse(caloriesText) ?? 0;

    final Diet newDiet = Diet(
      dailyCals: dailyCals,
      dietType: _selectedDietType,
      startDate: DateTime.now(),
    );

    DietControl().addDiet(newDiet);
    String dietString = _selectedDietType != DietType.other ?
      _selectedDietType.toString().split('.')[1]
    : '';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$dietString diet created!'),
        duration: const Duration(seconds: 3),
      ),
    );
    _caloriesController.clear();
    setState(() {
      _selectedDietType = DietType.other;
    });
  }
}
