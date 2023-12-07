import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/model/diet.dart';
import 'package:life_balance_plus/control/diets_control.dart';

class CreateDietForm extends StatefulWidget {
  @override
  _CreateDietFormState createState() => _CreateDietFormState();
}

class _CreateDietFormState extends State<CreateDietForm> {
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _dietNameController = TextEditingController();
  DietType _selectedDietType = DietType.other;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create a New Diet',
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _dietNameController,
            decoration: InputDecoration(
              labelText: 'Diet Name',
              border: OutlineInputBorder(),
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
          _buildDropdown(
            'Diet Type',
            DietType.values,
            _selectedDietType,
            (DietType? value) {
              setState(() {
                _selectedDietType = value ?? DietType.other;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Start Date: '),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    'Select Date - ${_formattedDate(_selectedDate)}',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Create Diet'),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>(String label, List<T> items, T selectedItem,
      void Function(T?)? onChanged) {
    return DropdownButtonFormField<T>(
      value: selectedItem,
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString().split('.').last),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formattedDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
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
      startDate: _selectedDate,
    );

    DietControl().addDiet(newDiet);
    String dietString = _selectedDietType != DietType.other
        ? _selectedDietType.toString().split('.')[1]
        : '';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$dietString diet created!'),
        duration: const Duration(seconds: 3),
      ),
    );
    _caloriesController.clear();
    _dietNameController.clear();
    setState(() {
      _selectedDietType = DietType.other;
      _selectedDate = DateTime.now();
    });
  }
}
