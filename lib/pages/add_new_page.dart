import 'package:flutter/material.dart';
import 'package:note_app/Models/note_model.dart';
import 'package:note_app/Provider/notes_provide.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class AddNewNotePage extends StatefulWidget {
  const AddNewNotePage({super.key});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contantController = TextEditingController();
  FocusNode noteFocus = FocusNode();

  void addNewNote() {
    Note newNote = Note(
      id: const Uuid().v1(),
      content: contantController.text,
      dateadded: DateTime.now(),
      title: titleController.text,
      userid: "thumarkeval",
    );

    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              addNewNote();
            },
            tooltip: "save",
          ),
        ],
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (val) {
                if (val != "") {
                  noteFocus.requestFocus();
                }
              },
              autofocus: true,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: 'Enter Title',
                border: InputBorder.none,
              ),
            ),
            20.heightBox,
            Expanded(
              child: TextField(
                  controller: contantController,
                  focusNode: noteFocus,
                  maxLines: null,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter Notes',
                    border: InputBorder.none,
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
