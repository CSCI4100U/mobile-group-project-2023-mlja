import 'package:flutter/material.dart';


class Set {
  int set;
  double weight;
  int reps;

  Set({
    required this.set,
    required this.weight,
    required this.reps,
  });
}

class WorkoutSessionPage extends StatefulWidget {
  @override
  _WorkoutSessionPageState createState() => _WorkoutSessionPageState();
}

class _WorkoutSessionPageState extends State<WorkoutSessionPage> {
  List<Set> data = [Set(set: 1, weight: 0, reps: 0)];
  int sets = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    data.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data.length < 1 ? Center(child: Text('No items')) :
      Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Set ${index + 1}'),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        data[index].weight = double.parse(value);
                      });
                    },
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        data[index].reps = int.parse(value);
                      });
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteRow(index);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: _addRow,
        child: Icon(Icons.add),
      ),
    );
  }

  void _deleteRow(int index) {
    setState(() {
      data.removeAt(index);
      sets--;
    });
  }

  void _addRow() {
    setState(() {
      sets++;
      data.add( Set( set: sets, weight: 0, reps: 0));
    });
  }
}
