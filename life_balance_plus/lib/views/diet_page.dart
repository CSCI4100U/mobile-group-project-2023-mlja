import 'package:flutter/material.dart';
import '../model/user.dart';


class DietPage extends StatefulWidget {
  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Diet Page'),
      ),
    );
  }
}
