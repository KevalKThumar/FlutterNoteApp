// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Models/user_model.dart';
import 'package:note_app/Provider/auth_provider.dart';
import 'package:note_app/pages/home_page.dart';
import 'package:note_app/pages/login_page.dart';
import 'package:note_app/widget/widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  // checkValue
  void checkValue(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();

    if (email == "" || password == "" || name == "") {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else {
      signup(email, name, password);
    }
  }

// signup
  void signup(email, name, password) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    User user = User(
      email: email,
      name: name,
      password: password,
      token: ''
    );

    await authProvider.signup(user, context);

    if (authProvider.isBack) {
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const LoginPage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
          child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                150.heightBox,
                // logo
                "Notes APP".text.size(40).fontWeight(FontWeight.bold).make(),
                70.heightBox,
                // first textfild for username
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        focusColor: Colors.blue,
                        hintText: "Enter your Name",
                        hintStyle: TextStyle(
                          color: Colors.grey[700],
                        ),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                  ),
                ),
                10.heightBox,
                // second passWord
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        focusColor: Colors.blue,
                        hintText: "Enter your E-mail",
                        hintStyle: TextStyle(
                          color: Colors.grey[700],
                        ),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                  ),
                ),
                10.heightBox,
                // confirm padssWord
                SizedBox(
                  height: 50,
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        focusColor: Colors.blue,
                        hintText: "Enter your password",
                        hintStyle: TextStyle(
                          color: Colors.grey[700],
                        ),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                  ),
                ),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Already have an account"
                        .text
                        .color(Colors.grey[500])
                        .make(),
                    5.widthBox,
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: "Login".text.size(15).make())
                  ],
                ),
                //button signup
                30.heightBox,

                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.height - 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blueGrey[900]),
                    ),
                    onPressed: () {
                      checkValue(context);
                    },
                    child: authProvider.isLoding == true
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : "Signup".text.uppercase.white.size(23).make(),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
