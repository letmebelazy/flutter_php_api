import 'package:flutter/material.dart';
import 'package:flutter_crud_using_php/models/environment.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_crud_using_php/models/student.dart';

import 'form.dart';

class Edit extends StatefulWidget {
  final Student student;
  Edit({this.student});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  TextEditingController ageController;

  Future editStudent() async {
    return await http.post(
        Uri.parse('${Env.URL_PREFIX}/update.php'),
        body: {
          'id': widget.student.id.toString(),
          'name': nameController.text,
          'ageController': ageController.text,
        }
    );
  }

  void _onConfirm(context) async {
    await editStudent();
  }

  @override
  void initState() {
    nameController = TextEditingController(text: widget.student.name);
    ageController = TextEditingController(text: widget.student.age.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
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
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
          child: const Text('CONFIRM'),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            primary: Colors.white
          ),
          onPressed: () => _onConfirm(context),
        ),
      ),
    );
  }
}
