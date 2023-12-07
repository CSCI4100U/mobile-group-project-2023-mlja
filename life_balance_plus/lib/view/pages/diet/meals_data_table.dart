import 'package:flutter/material.dart';
import '../../../data/model/meal.dart';

/// A StatefulWidget that displays a DataTable for meals.
class MealsDataTable extends StatefulWidget {
  /// List of meals to be displayed in the DataTable.
  final List<Meal> meals;

  /// Constructor to initialize the MealsDataTable.
  MealsDataTable({Key? key, required this.meals}) : super(key: key);

  @override
  State<MealsDataTable> createState() => _MealsDataTableState();
}

/// The State class for MealsDataTable.
class _MealsDataTableState extends State<MealsDataTable> {
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  /// Builds DataRows based on the provided list of meals.
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
    // Build DataRows based on the provided meals.
    List<DataRow> dataRows = _buildDataRows(widget.meals);

    // Scrollable DataTable with specified column widths.
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        columnSpacing: 5.0, // Adjust the spacing between columns
        dataRowHeight: 40.0, // Set the height for each DataRow

        // Define columns for the DataTable
        columns: [
          DataColumn(
            label: SizedBox(
              width: 100.0,
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
              width: 60.0,
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
              width: 40.0,
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
              width: 45.0,
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
              width: 30.0,
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
        // Display rows containing meal data
        rows: dataRows,
      ),
    );
  }
}
