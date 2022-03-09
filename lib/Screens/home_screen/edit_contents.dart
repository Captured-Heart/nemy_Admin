// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nemycraft_admin/constants.dart';

class EditContents extends StatelessWidget {
  EditContents({Key? key}) : super(key: key);

  final Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: 
      Container(
        height: size.height,
        width: size.width,
        margin: EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: size.height * 0.04,
          top: 15,
        ),
        // color: Colors.white,
        child: Column(
          children: [
            Text(
              'This page will basically guide you to other pages where you can edit the articles',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.yellow[100]),
                    child: ListTile(
                      onTap: () {
                        // Navigator.pushReplacementNamed(context, '/editHome');
                        Navigator.of(context).pushNamed('/editHome');
                      },
                      title: Text(
                        'HOME',
                        style: constants.kTextStyleTitleBold,
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          text:
                              'This page will lead you to edit everything found on ',
                          style: constants.kTextStyleBold
                              .copyWith(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: 'NemysCraft Home Page',
                              style: constants.kTextStyleBold.copyWith(
                                  color: Colors.blue, letterSpacing: 2),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.yellow[100]),
                    child: ListTile(
                      onTap: () {},
                      title: Text(
                        'ABOUT',
                        style: constants.kTextStyleTitleBold,
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          text:
                              'This page will lead you to edit everything found on ',
                          style: constants.kTextStyleBold
                              .copyWith(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: 'NemysCraft About Page',
                              style: constants.kTextStyleBold.copyWith(
                                  color: Colors.blue, letterSpacing: 2),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.yellow[100]),
                    child: ListTile(
                      onTap: () {},
                      title: Text(
                        'CONTACT US',
                        style: constants.kTextStyleTitleBold,
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          text:
                              'This page will lead you to edit everything found on ',
                          style: constants.kTextStyleBold
                              .copyWith(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: 'NemysCraft Contact Us Page',
                              style: constants.kTextStyleBold.copyWith(
                                  color: Colors.blue, letterSpacing: 2),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomePageListTiles extends StatelessWidget {
  const HomePageListTiles({
    Key? key,
    this.containerColor,
    this.buttonText,
    this.title,
    required this.size, required this.onPressed,
  }) : super(key: key);
  final Color? containerColor;
  final String? buttonText, title;
  final Size size;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: containerColor),
      child: ListTile(
        minVerticalPadding: 20,
        style: ListTileStyle.drawer,
        title: Text(
          title!,
          style: TextStyle(fontSize: 19),
        ),
        trailing: SizedBox(
          width: size.width * 0.4,
          child: TextButton(
            onPressed: onPressed,
            child: Text(
              buttonText!,
              style: TextStyle(fontSize: 19, color: Colors.white),
            ),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.all(15),
              ),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blue.shade300),
            ),
          ),
        ),
      ),
    );
  }
}
