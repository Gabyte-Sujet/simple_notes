import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';

class AddEditNote extends StatefulWidget {
  const AddEditNote({Key? key}) : super(key: key);

  static const routeName = '/add_edit_note';

  @override
  State<AddEditNote> createState() => _AddEditNoteState();
}

class _AddEditNoteState extends State<AddEditNote> {
  final _formKey = GlobalKey<FormState>();
  var note = {
    'noteName': '',
    'noteDescription': '',
  };

  var initialValues = {
    'name': '',
    'description': '',
  };

  @override
  void didChangeDependencies() {
    final noteName = ModalRoute.of(context)?.settings.arguments;
    if (noteName != null) {
      var _edited =
          Provider.of<UserNotes>(context).findById(noteName as String);
      initialValues = {
        'name': _edited.name,
        'description': _edited.description,
      };
    }
    super.didChangeDependencies();
  }

  void _addNote(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    if (initialValues['name']!.isNotEmpty) {
      Provider.of<UserNotes>(context, listen: false).updateNote(
        note['noteName'] as String,
        note['noteDescription'] as String,
      );
    } else {
      Provider.of<UserNotes>(context, listen: false).addNote(
        note['noteName'] as String,
        note['noteDescription'] as String,
      );
    }

    Navigator.of(context).pop();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<UserNotes>(context, listen: false).notes);
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Edit note'),
        actions: [
          IconButton(
            onPressed: () => _addNote(context),
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          child: Container(
            width: deviceSize.width * 0.80,
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: initialValues['name'],
                      decoration: InputDecoration(labelText: 'Note-Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid Name for Note!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        note['noteName'] = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: initialValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Invalid Description!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        note['noteDescription'] = value!;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _addNote(context),
                      child: Text('Add Note'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
