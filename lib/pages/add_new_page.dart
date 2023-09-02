import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AddNewPage extends StatelessWidget {
  const AddNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: "Add New Page".text.make().centered(),
        ),
      ),
    );
  }
}
