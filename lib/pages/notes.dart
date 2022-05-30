import 'package:flutter/material.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  static const routeName = '/notes';

  @override
  Widget build(BuildContext context) {
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
      body: Center(),
    );
  }
}
