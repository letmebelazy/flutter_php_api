import 'package:flutter/material.dart';

class AppForm extends StatefulWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  TextEditingController ageController;

  AppForm({this.formKey, this.nameController, this.ageController});

  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  String _validateName(String value) {
    if (value.length < 3) return 'Name must be more than 2 characters';
    return null;
  }

  String _validatedAge(String value) {
    Pattern pattern = r'(?<=\s|^)\d+(?=\s|$)';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Age must be a number';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidate: true,
      child: Column(
        children: [
          TextFormField(
            controller: widget.nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Name'),
            validator: _validateName,
          ),
          TextFormField(
            controller: widget.ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Age'),
            validator: _validatedAge,
          ),
        ],
      ),
    );
  }
}
