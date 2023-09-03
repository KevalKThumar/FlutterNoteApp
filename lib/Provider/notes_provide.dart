import 'package:flutter/material.dart';
import 'package:note_app/services/api_service.dart';

import '../Models/note_model.dart';

class NotesProvider with ChangeNotifier {
  List<Note> notes = [];
  bool isLoding = true;
  NotesProvider() {
    fatchNotes();
  }

  void sortNotes() {
    notes = notes..sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  void addNote(Note note) {
    sortNotes();
    notes.add(note);
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    sortNotes();
    notes[indexOfNote] = note;
    notifyListeners();
    ApiService.addNote(note);
  }

  List<Note> getFilterdNote(String searchQuery) {
    return notes
        .where((element) =>
            element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            element.content!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNode(note);
  }

  void fatchNotes() async {
    notes = await ApiService.fatchnotes("thumarkeval");
    sortNotes();
    isLoding = false;
    notifyListeners();
  }
}
