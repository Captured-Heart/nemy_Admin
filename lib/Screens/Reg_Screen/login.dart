// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nemycraft_admin/Screens/Reg_Screen/start_up.dart';
import 'package:nemycraft_admin/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final Constants constants = Constants();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'LOG IN',
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
                  key: _formKeyLogin,
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
                        textController: passController,
                        obscureText: _obscureText,
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
                      _isLoading
                          ? LoginButton(
                              size: size,
                              text: 'Log In',
                              onPressed: signin,
                              bgColor: Colors.black,
                              fgColor: Colors.white,
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            )
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
      duration: Duration(seconds: 2),
      backgroundColor: Color.fromARGB(255, 40, 41, 54),
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

  Future signin() async {
    final form = _formKeyLogin.currentState;
    try {
      if (form!.validate()) {
        form.save();
        setState(() {
          _isLoading = false;
        });
        final _user = await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
        );
        setState(() {
          _isLoading = true;
        });
        if (_user.user!.emailVerified) {
          Navigator.pushReplacementNamed(context, '/homeScreen');
        } else {
          _showSnackBar('Please Verify your Email before you can Login');
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        print('errorknk');
      }
    } catch (error) {
      _showSnackBar(error.toString());
      setState(() {
        _isLoading = true;
      });
    }
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.text,
    required this.hintText,
    this.suffix,
    this.obscureText,
    this.textController,
  }) : super(key: key);
  final String text, hintText;
  final Widget? suffix;
  final bool? obscureText;
  final TextEditingController? textController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
              color: Colors.grey.shade400, fontSize: 22, wordSpacing: 5),
        ),
        SizedBox(height: 4),
        TextFormField(
          cursorColor: Colors.white,
          controller: textController,
          obscureText: obscureText!,
          style: TextStyle(
            color: Colors.grey.shade200,
            fontSize: 16,
            letterSpacing: 5,
            fontStyle: FontStyle.normal,
          ),
          decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: EdgeInsets.all(13),
            hintText: hintText,
            filled: true,
            fillColor: Color.fromARGB(255, 40, 41, 54),
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 16,
            ),
            isDense: true,
            // suffixIconConstraints: BoxConstraints.tight(Size.zero),
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
