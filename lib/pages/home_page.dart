import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Provider/notes_provide.dart';
import 'package:note_app/pages/add_new_page.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Models/note_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvide = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: "Notes APP".text.white.fontFamily(AutofillHints.jobTitle).make(),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: GridView.builder(
            itemCount: notesProvide.notes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              Note currentNote = notesProvide.notes[index];
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    currentNote.title!.text
                        .size(20)
                        .fontWeight(FontWeight.bold)
                        .maxLines(1)
                        .overflow(TextOverflow.ellipsis)
                        .make(),
                    7.heightBox,
                    currentNote.content!.text
                        .color(Colors.grey[700])
                        .size(17)
                        .maxLines(5)
                        .overflow(TextOverflow.ellipsis)
                        .make(),
                  ],
                ),
              )
                  .box
                  .white
                  .border(width: 2)
                  .margin(const EdgeInsets.all(5))
                  .padding(const EdgeInsets.all(10))
                  .roundedSM
                  .outerShadow
                  .make();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const AddNewNotePage(),
              fullscreenDialog: true, // for full screen dialog
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
