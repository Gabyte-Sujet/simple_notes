import 'package:flutter/material.dart';

class AddEditNote extends StatelessWidget {
  const AddEditNote({Key? key}) : super(key: key);

  static const routeName = '/add_edit_note';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Edit note'),
      ),
      body: Center(),
    );
  }
}
