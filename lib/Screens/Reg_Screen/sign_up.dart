// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nemycraft_admin/Auth/auth_methods.dart';
import 'package:nemycraft_admin/Screens/Reg_Screen/login.dart';
import 'package:nemycraft_admin/Screens/Reg_Screen/start_up.dart';
import 'package:nemycraft_admin/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;
  final Constants constants = Constants();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          margin: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'SIGN UP',
                    style: constants.kTextStyleBold
                        .copyWith(fontSize: size.width * 0.08),
                  ),
                ),
                Spacer(),
                Center(
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/images/saly.png',
                      height: size.height * 0.25,
                      width: size.width * 0.8,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        text: 'Your Email',
                        hintText: 'example@email.com',
                        obscureText: false,
                        textController: emailController,
                      ),
                      SizedBox(height: 20),
                      TextFieldWidget(
                        text: 'Your Password',
                        hintText: 'Password',
                        obscureText: _obscureText,
                        textController: passController,
                        suffix: InkWell(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 25,
                              color: _obscureText ? Colors.white : Colors.grey,
                            )),
                      ),
                      SizedBox(height: 20),
                      LoginButton(
                        size: size,
                        text: 'Sign Up',
                        onPressed: signUp,
                        bgColor: Colors.black,
                        fgColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String error) {
    final _snackBar = SnackBar(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.error, color: Colors.red),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              error,
              // maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  Future signUp() async {
    final form = _formKey.currentState;
    try {
      if (form!.validate()) {
        form.save();

        await _authMethods.signUpWithEmailAndPassword(
          emailController.text,
          passController.text,
        );
      //    if (user.isEmailVerified) {
      //           Navigator.pushReplacementNamed(context, '/homeScreen');

       
      // } else {
      //   _showSnackBar('Please Verify your Email before you can Login');
      // }
      } else {
        // print('errorknk');
      }
    } catch (error) {
      _showSnackBar(error.toString());
    }
  }
}
