import 'package:flutter/material.dart';
import 'package:note_app/pages/add_new_page.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Notes APP".text.white.fontFamily(AutofillHints.jobTitle).make(),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: GridView.builder(
          itemCount: 5,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(5),
              color: Colors.blue,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewPage(),
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
