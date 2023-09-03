import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Provider/notes_provide.dart';
import 'package:note_app/pages/add_new_page.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Models/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";
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
      body: notesProvide.isLoding == false
          ? SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: (notesProvide.notes.isNotEmpty)
                    ? ListView(
                        children: [
                          SizedBox(
                            height: 50,
                            child: TextField(
                              onChanged: (val) {
                                setState(() {
                                  searchQuery = val;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "Search Note",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                            ),
                          ),
                          (notesProvide.getFilterdNote(searchQuery).isNotEmpty)
                              ? GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: notesProvide
                                      .getFilterdNote(searchQuery)
                                      .length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    Note currentNote = notesProvide
                                        .getFilterdNote(searchQuery)[index];
                                    return SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        .make()
                                        .onDoubleTap(
                                      () {
                                        //delete
                                        notesProvide.deleteNote(currentNote);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    "Notes deleted succesfully"
                                                        .text
                                                        .make()));
                                      },
                                      hitTestBehavior: HitTestBehavior.opaque,
                                    ).onTap(() {
                                      //update
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => AddNewNotePage(
                                            isUpdate: true,
                                            note: currentNote,
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                )
                              : "No result found"
                                  .text
                                  .size(15)
                                  .makeCentered()
                                  .expand()
                                  .box
                                  .padding(
                                      const EdgeInsets.symmetric(vertical: 30))
                                  .make()
                        ],
                      )
                    : "No Notes Found!!".text.size(15).makeCentered(),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const AddNewNotePage(isUpdate: false),
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
