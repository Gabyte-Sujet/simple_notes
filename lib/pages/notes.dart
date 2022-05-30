import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import './add_edit_note.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  static const routeName = '/notes';

  void deleteProduct(String name) {}

  @override
  Widget build(BuildContext context) {
    final userNotes = Provider.of<UserNotes>(context).notes;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Notes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: userNotes
              .map((e) => Container(
                    child: Card(
                      child: ListTile(
                        title: Text(e.name),
                        subtitle: Text(e.description),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      AddEditNote.routeName,
                                      arguments: e.name);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.purple,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Provider.of<UserNotes>(context, listen: false)
                                      .deleteNote(e.name);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddEditNote.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
