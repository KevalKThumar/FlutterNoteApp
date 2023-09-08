// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:note_app/Provider/auth_provider.dart';
import 'package:note_app/Provider/notes_provide.dart';
import 'package:note_app/pages/add_new_page.dart';
import 'package:note_app/pages/login_page.dart';
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
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
            ).onTap(() {
              Provider.of<AuthProvider>(context).logout();
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => const LoginPage()));
            }),
          )
        ],
        leading: "${authProvider.user.name}"
            .text
            .overflow(TextOverflow.ellipsis)
            .maxLines(1)
            .size(25)
            .white
            .fontWeight(FontWeight.w500)
            .make()
            .box
            .margin(const EdgeInsets.only(left: 15, top: 15))
            .make(),
        title: "Notes APP".text.white.fontFamily(AutofillHints.jobTitle).make(),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: notesProvider.isLoding == false
          ? SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: (notesProvider.notes.isNotEmpty)
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
                                    borderSide: BorderSide(
                                        color: Colors.black87, width: 3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                            ),
                          ),
                          10.heightBox,
                          (notesProvider.getFilterdNote(searchQuery).isNotEmpty)
                              ? GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: notesProvider
                                      .getFilterdNote(searchQuery)
                                      .length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    Note currentNote = notesProvider
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
                                        .border(width: 2, color: Colors.black38)
                                        .margin(const EdgeInsets.all(5))
                                        .padding(const EdgeInsets.all(10))
                                        .roundedSM
                                        .outerShadow
                                        .make()
                                        .onDoubleTap(
                                      () {
                                        //delete
                                        notesProvider.deleteNote(currentNote);
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
              child: SpinKitCircle(
                color: Colors.black,
                size: 40.0,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[900],
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
