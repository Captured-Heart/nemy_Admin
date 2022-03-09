// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nemycraft_admin/Auth/database.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Home/components/dialogs.dart';
import 'package:nemycraft_admin/Screens/Reg_Screen/start_up.dart';

class EditContactPage extends StatefulWidget {
  const EditContactPage({Key? key}) : super(key: key);

  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  static final GlobalKey<FormState> _formKeyContact = GlobalKey<FormState>();
  final DataBaseService dataBaseService = DataBaseService();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  final Dialogs dialogs = Dialogs();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Edit_Contact_Us')),
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
                key: _formKeyContact,
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
                        'assets/images/nemyContact.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ADDRESS'),
                        TextFormField(
                          controller: _addressController,
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
                        Text('PHONE'),
                        TextFormField(
                          controller: _phoneController,
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
                        Text('E-MAIL'),
                        TextFormField(
                          controller: _emailController,
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
                      onPressed: postContacts,
                      fgColor: Colors.white,
                      bgColor: Colors.blue,
                    ),
                    SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postContacts() async {
    final form = _formKeyContact.currentState;

    try {
      if (form!.validate()) {
        setState(() {
          _isLoading = true;
        });
        Map<String, String> adsDetails = {
          'address': _addressController.text,
          'phone no': _phoneController.text,
          'email': _emailController.text
        };
        await dataBaseService.setAdsDetails(adsDetails);
        _addressController.clear();
        _phoneController.clear();
        _emailController.clear();
        dialogs.successDialog(
          context: context,
          titleText: 'SUCCESS',
          contentText:
              'You have successfully posted the Contacts, kindly check your websites for update',
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
