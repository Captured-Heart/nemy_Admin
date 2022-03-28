// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nemycraft_admin/Auth/database.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Home/components/dialogs.dart';
import 'package:nemycraft_admin/Screens/Reg_Screen/start_up.dart';

class EditAdsPage extends StatefulWidget {
  const EditAdsPage({Key? key}) : super(key: key);

  @override
  _EditAdsPageState createState() => _EditAdsPageState();
}

class _EditAdsPageState extends State<EditAdsPage> {
  static final GlobalKey<FormState> _formKeyAds = GlobalKey<FormState>();
  final DataBaseService dataBaseService = DataBaseService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subTitleController = TextEditingController();
  bool _isLoading = false;
  final Dialogs dialogs = Dialogs();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Edit_Ads')),
      backgroundColor: Colors.teal[50],
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKeyAds,
                child: Column(
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'Below is the screenshot of the section from the website',
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
                        'assets/images/nemyAds.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('TITLE'),
                        TextFormField(
                          controller: _titleController,
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
                        Text('SUBTITLE'),
                        TextFormField(
                          controller: _subTitleController,
                          maxLines: 4,
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
                      onPressed: postAds,
                      fgColor: Colors.white,
                      bgColor: Colors.blue,
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postAds() async {
    final form = _formKeyAds.currentState;

    try {
      if (form!.validate()) {
        setState(() {
          _isLoading = true;
        });
        Map<String, String> adsDetails = {
          'title': _titleController.text,
          'subtitle': _subTitleController.text,
        };
        await dataBaseService.setAdsDetails(adsDetails);
        _titleController.clear();
        _subTitleController.clear();
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
            contentText: 'Fill all the fields before posting');
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
