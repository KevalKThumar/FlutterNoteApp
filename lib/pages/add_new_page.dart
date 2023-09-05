import 'package:flutter/material.dart';
import 'package:note_app/Models/note_model.dart';
import 'package:note_app/Provider/notes_provide.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class AddNewNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNotePage({super.key, required this.isUpdate, this.note});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contantController = TextEditingController();
  FocusNode noteFocus = FocusNode();

  void checkValidation() {
    if (titleController.text == "" || contantController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')));
    } else {
      widget.isUpdate == true ? updateNewNote() : addNewNote();
      widget.isUpdate == true
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: "Notes update succesfully".text.make()))
          : ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: "Notes add succesfully".text.make()));
    }
  }

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

  void updateNewNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contantController.text;
    widget.note!.dateadded = DateTime.now();

    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate == true) {
      titleController.text = widget.note!.title!;
      contantController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: widget.isUpdate == true
            ? "${widget.note!.title}"
                .text
                .white
                .size(19)
                .overflow(TextOverflow.ellipsis)
                .make()
            : titleController.text.text.make(),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              checkValidation();
            },
            tooltip: "save",
          ),
        ],
        backgroundColor: Colors.blueGrey[900],
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
              autofocus: widget.isUpdate == true ? false : true,
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
