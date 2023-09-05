// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Models/user_model.dart';
import 'package:note_app/Provider/auth_provider.dart';
import 'package:note_app/pages/home_page.dart';
import 'package:note_app/pages/signup_page.dart';
import 'package:note_app/widget/widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // checkValue
  void checkValue(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      UIHelper.showAlertDialog(
          context, "Incomplete Data", "Please fill all the fields");
    } else {
      login(email, password);
    }
  }

// login
  void login(email, password) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    User user = User(
      email: email,
      password: password,
      name: "",
    );

    await authProvider.login(user);

    if (authProvider.isBack) {
      Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const HomePage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    log(authProvider.isLoding.toString());
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
                    "Create a new account".text.color(Colors.grey[500]).make(),
                    5.widthBox,
                    SizedBox(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const SignupPage()));
                        },
                        child: "Signup".text.size(15).make(),
                      ),
                    )
                  ],
                ),
                //button signup
                30.heightBox,
                authProvider.isLoding == true
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : SizedBox(
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
                          child: "Login".text.uppercase.white.size(23).make(),
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
