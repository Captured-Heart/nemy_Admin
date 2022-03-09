// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nemycraft_admin/Auth/database.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Home/components/dialogs.dart';
import 'package:nemycraft_admin/Screens/Reg_Screen/start_up.dart';

class EditFollowPage extends StatefulWidget {
  const EditFollowPage({Key? key}) : super(key: key);

  @override
  _EditFollowPageState createState() => _EditFollowPageState();
}

class _EditFollowPageState extends State<EditFollowPage> {
  static final GlobalKey<FormState> _formKeyFollow = GlobalKey<FormState>();
  final DataBaseService dataBaseService = DataBaseService();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  bool _isLoading = false;
  final Dialogs dialogs = Dialogs();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Edit_Follow_Us')),
      backgroundColor: Colors.teal[50],
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              // height: size.height,
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKeyFollow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'Below is the screenshot of the section from the website,  PLEASE POST ONLY THE SOCIAL MEDIA LINKS/URLS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.35,
                      width: size.width,
                      margin: EdgeInsets.symmetric(
                        vertical: size.height * 0.04,
                      ),
                      child: Image.asset(
                        'assets/images/nemyContact.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.facebookF,
                                color: Colors.blue),
                            SizedBox(width: 5),
                            Text('FACEBOOK'),
                          ],
                        ),
                        TextFormField(
                          controller: _facebookController,
                          validator: (text) {
                            return text!.isEmpty
                                ? 'The Field can not be empty'
                                : null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.twitter,
                                color: Colors.blue.shade300),
                            SizedBox(width: 5),
                            Text('TWITTER'),
                          ],
                        ),
                        TextFormField(
                          controller: _twitterController,
                          validator: (text) {
                            return text!.isEmpty
                                ? 'The Field can not be empty'
                                : null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.instagram,
                                color: Colors.pink),
                            SizedBox(width: 5),
                            Text('INSTAGRAM'),
                          ],
                        ),
                        TextFormField(
                          controller: _instagramController,
                          validator: (text) {
                            return text!.isEmpty
                                ? 'The Field can not be empty'
                                : null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(FontAwesomeIcons.whatsapp,
                                color: Colors.green),
                            SizedBox(width: 5),
                            Text('WHATSAPP'),
                          ],
                        ),
                        TextFormField(
                          controller: _whatsappController,
                          validator: (text) {
                            return text!.isEmpty
                                ? 'The Field can not be empty'
                                : null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    LoginButton(
                      size: size,
                      text: 'POST',
                      onPressed: postFollow,
                      fgColor: Colors.white,
                      bgColor: Colors.blue,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postFollow() async {
    final form = _formKeyFollow.currentState;

    try {
      if (form!.validate()) {
        setState(() {
          _isLoading = true;
        });
        Map<String, String> adsDetails = {
          'facebook': _facebookController.text,
          'twitter': _twitterController.text,
          'instagram': _instagramController.text,
          'whatsapp': _whatsappController.text
        };
        await dataBaseService.setFollowUsDetails(adsDetails);
        _facebookController.clear();
        _twitterController.clear();
        _instagramController.clear();
        _whatsappController.clear();
        dialogs.successDialog(
          context: context,
          titleText: 'SUCCESS',
          contentText:
              'You have successfully posted the ads, kindly check your websites for update',
        );
      } else if (!form.validate()) {
        dialogs.successDialog(
            context: context,
            titleText: 'ERROR',
            contentText:
                'FILL UP THE OPTIONS!, P.S: You can actually fill the ones you have and fill any random text for the ones you don\'t have, and also feel free to contact Marcel for Social Media pages you want to add');
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      dialogs.successDialog(
          context: context,
          titleText: 'SYSTEM ERROR',
          contentText: e.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }
}
