import 'package:flutter/material.dart';
import '../../../data/model/meal.dart';

class MealsDataTable extends StatefulWidget {
  MealsDataTable({Key? key, required this.meals}) : super(key: key);
  final List<Meal> meals;

  @override
  State<MealsDataTable> createState() => _MealsDataTableState();
}

class _MealsDataTableState extends State<MealsDataTable> {
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  List<DataRow> _buildDataRows(List<Meal> meals) {
    return meals.map((meal) {
      return DataRow(
        cells: [
          DataCell(Text("${meal.name}")),
          DataCell(Text("${meal.mealType}")),
          DataCell(Text("${meal.fats}")),
          DataCell(Text("${meal.proteins}")),
          DataCell(Text("${meal.carbs}")),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<DataRow> dataRows = _buildDataRows(widget.meals);

    return Scaffold(
      body: DataTable(
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        columns: [
          DataColumn(
            label: Text("Meal"),
            onSort: (columnIndex, ascending) {
              setState(() {
                _sortColumnIndex = columnIndex;
                _sortAscending = ascending;
                widget.meals.sort((a, b) {
                  if (ascending) {
                    return a.name.compareTo(b.name);
                  } else {
                    return b.name.compareTo(a.name);
                  }
                });
              });
            },
          ),
          DataColumn(
            label: Text("Type"),
            onSort: (columnIndex, ascending) {
              setState(() {
                _sortColumnIndex = columnIndex;
                _sortAscending = ascending;
                widget.meals.sort((a, b) {
                  if (ascending) {
                    return a.mealType.compareTo(b.mealType);
                  } else {
                    return b.mealType.compareTo(a.mealType);
                  }
                });
              });
            },
          ),
          DataColumn(
            label: Text("Fats"),
            onSort: (columnIndex, ascending) {
              setState(() {
                _sortColumnIndex = columnIndex;
                _sortAscending = ascending;
                widget.meals.sort((a, b) {
                  if (ascending) {
                    return a.fats!.compareTo(b.fats!);
                  } else {
                    return b.fats!.compareTo(a.fats!);
                  }
                });
              });
            },
          ),
          DataColumn(
            label: Text("Proteins"),
            onSort: (columnIndex, ascending) {
              setState(() {
                _sortColumnIndex = columnIndex;
                _sortAscending = ascending;
                widget.meals.sort((a, b) {
                  if (ascending) {
                    return a.proteins!.compareTo(b.proteins!);
                  } else {
                    return b.proteins!.compareTo(a.proteins!);
                  }
                });
              });
            },
          ),
          DataColumn(
            label: Text("Carbs"),
            onSort: (columnIndex, ascending) {
              setState(() {
                _sortColumnIndex = columnIndex;
                _sortAscending = ascending;
                widget.meals.sort((a, b) {
                  if (ascending) {
                    return a.carbs!.compareTo(b.carbs!);
                  } else {
                    return b.carbs!.compareTo(a.carbs!);
                  }
                });
              });
            },
          ),
        ],
        rows: dataRows,
      ),
    );
  }
}
