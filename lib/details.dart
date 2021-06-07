import 'package:flutter/material.dart';
import 'package:flutter_crud_using_php/models/environment.dart';
import 'package:flutter_crud_using_php/models/student.dart';
import 'package:http/http.dart' as http;
import 'edit.dart';

class Details extends StatefulWidget {
  final Student student;
  Details({this.student});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void deleteStudent(context) async {
    await http.post(
      Uri.parse('${Env.URL_PREFIX}/delete.php'),
      body: {
        'id': widget.student.id.toString()
      }
    );
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  void confirmDelete(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Are you sure you want to delete this?'),
            actions: [
              IconButton(
                  icon: Icon(Icons.cancel),
                  color: Colors.red,
                  onPressed: () => Navigator.of(context).pop,
              ),
              IconButton(
                  icon: Icon(Icons.check_circle),
                  color: Colors.blue,
                  onPressed: () => deleteStudent(context),
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => confirmDelete(context),
          )
        ],
      ),
      body: Container(
        height: 270.0,
        padding: const EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${widget.student.name}',
              style: TextStyle(fontSize: 20.0),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Text(
              'Age: ${widget.student.age}',
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Edit(student: widget.student))
        ),
      ),
    );
  }
}
