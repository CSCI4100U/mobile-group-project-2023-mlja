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

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        columnSpacing: 5.0, // Adjust the spacing between columns
        columns: [
          DataColumn(
            label: SizedBox(
              width: 100.0, // Set the width for the "Meal" column
              child: Text("Meal"),
            ),
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
            label: SizedBox(
              width: 50.0, // Set the width for the "Type" column
              child: Text("Type"),
            ),
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
            label: SizedBox(
              width: 40.0, // Set the width for the "Carbs" column
              child: Text("Carbs"),
            ),
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
          DataColumn(
            label: SizedBox(
              width: 50.0, // Set the width for the "Proteins" column
              child: Text("Protein"),
            ),
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
            label: SizedBox(
              width: 30.0, // Set the width for the "Fats" column
              child: Text("Fats"),
            ),
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
        ],
        rows: dataRows,
      ),
    );
  }
}
