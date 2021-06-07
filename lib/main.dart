import 'package:flutter/material.dart';

import 'create.dart';
import 'details.dart';
import 'edit.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + PHP CRUD',
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/create': (context) => Create(),
        '/details': (context) => Details(),
        '/edit': (context) => Edit(),
      }
    );
  }
}
