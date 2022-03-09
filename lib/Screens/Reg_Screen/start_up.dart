// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nemycraft_admin/constants.dart';

class StartUp extends StatelessWidget {
  StartUp({Key? key}) : super(key: key);

  final Constants constants = Constants();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.07,
              left: 15,
              child: Text(
                'Welcome NEMY !',
                style: constants.kTextStyleBold
                    .copyWith(fontSize: size.width * 0.085),
              ),
            ),
            Positioned(
              bottom: size.height * 0.13,
              child: LoginButton(
                size: size,
                text: 'Log in',
                bgColor: Colors.white,
                fgColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
            Center(
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/saly.png',
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: LoginButton(
                size: size,
                text: 'Sign Up',
                bgColor: Colors.black,
                fgColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/signUp');

                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.size,
    required this.text,
    this.fgColor,
    this.bgColor,
    required this.onPressed,
  }) : super(key: key);

  final Size size;
  final String text;
  final Color? fgColor, bgColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            letterSpacing: 7,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(3),
          backgroundColor: MaterialStateProperty.all<Color>(
            bgColor!,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            fgColor!,
          ),
          fixedSize: MaterialStateProperty.all<Size>(
            Size.fromWidth(size.width * 0.95),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 18),
          ),
          side: MaterialStateProperty.all<BorderSide>(BorderSide(
            color: Colors.white,
          )),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
