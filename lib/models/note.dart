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

  Map<String, userNote> userNotes = {};

  void addNote(String name, String description) {
    if (userNotes.containsKey(name)) {
      return;
    }
    userNotes.putIfAbsent(
        name, () => userNote(name: name, description: description));

    _notes.add(userNote(name: name, description: description));

    notifyListeners();
  }

  void updateNote(String noteName, String noteDescription) {
    var noteElement = _notes.indexWhere((element) => element.name == noteName);
    _notes[noteElement] =
        userNote(description: noteDescription, name: noteName);
    notifyListeners();
  }

  userNote findById(String name) {
    return _notes.firstWhere((product) => product.name == name);
  }

  void deleteNote(String name) {
    var noteElement = _notes.indexWhere((element) => element.name == name);
    _notes.removeAt(noteElement);
    notifyListeners();
  }
}
