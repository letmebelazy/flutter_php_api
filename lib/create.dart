import 'package:flutter/material.dart';
import 'package:flutter_crud_using_php/models/environment.dart';
import 'package:http/http.dart' as http;

import 'form.dart';

class Create extends StatefulWidget {
  final Function refreshStudentList;
  Create({this.refreshStudentList});

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  Future _createStudent() async {
    return await http.post(
      Uri.parse('${Env.URL_PREFIX}/create.php'),
      body: {
        'name': nameController.text,
        'age': ageController.text
      }
    );
  }

  void _onConfirm(context) async {
    await _createStudent();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
          child: Text('CONFIRM'),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            primary: Colors.white,
          ),
          onPressed: () {
            if (formKey.currentState.validate()) {
              _onConfirm(context);
            }
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: AppForm(
              formKey: formKey,
              nameController: nameController,
              ageController: ageController
            ),
          ),
        ),
      ),
    );
  }
}
