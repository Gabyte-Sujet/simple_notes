import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/sign_in.dart';
import './pages/sign_up.dart';
import './pages/notes.dart';
import './pages/add_edit_note.dart';
import './models/user.dart';
import './models/note.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Users(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserNotes(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignIn(),
        routes: {
          SignIn.routeName: (context) => SignIn(),
          SignUp.routeName: (context) => SignUp(),
          Notes.routeName: (context) => Notes(),
          AddEditNote.routeName: (context) => AddEditNote(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Simple Notes'),
//       ),
//       body: Center(
//         child: Text('hey'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
