import 'package:flutter/material.dart';

class userNote {
  final String name;
  final String description;

  userNote({
    required this.name,
    required this.description,
  });
}

class UserNotes with ChangeNotifier {
  List<userNote> _notes = [];

  List<userNote> get notes {
    return [..._notes];
  }
}
