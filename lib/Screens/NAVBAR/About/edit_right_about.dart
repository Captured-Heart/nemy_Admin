// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nemycraft_admin/Auth/database.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Home/components/dialogs.dart';
import 'package:nemycraft_admin/Screens/Reg_Screen/start_up.dart';

class EditRightAboutPage extends StatefulWidget {
  const EditRightAboutPage({Key? key}) : super(key: key);

  @override
  _EditRightAboutPageState createState() => _EditRightAboutPageState();
}

class _EditRightAboutPageState extends State<EditRightAboutPage> {
  static final GlobalKey<FormState> _formKeyRightAbout = GlobalKey<FormState>();
  final DataBaseService dataBaseService = DataBaseService();
  final TextEditingController _title1Controller = TextEditingController();
  final TextEditingController _subtitle1Controller = TextEditingController();
  final TextEditingController _title2Controller = TextEditingController();
  final TextEditingController _subtitle2Controller = TextEditingController();
  final TextEditingController _title3Controller = TextEditingController();
  final TextEditingController _subtitle3Controller = TextEditingController();
  final TextEditingController _title4Controller = TextEditingController();
  final TextEditingController _subtitle4Controller = TextEditingController();
  bool _isLoading = false;
  final Dialogs dialogs = Dialogs();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TransformationController controller = TransformationController();

    return Scaffold(
      appBar: AppBar(title: Text('Edit_Right_About')),
      backgroundColor: Colors.teal[50],
      body: SingleChildScrollView(
        child: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: SafeArea(
            child: Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.red)),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      'Below is the screenshot of the section from the website, then click on POST',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  InteractiveViewer(
                    transformationController: controller,
                    boundaryMargin: EdgeInsets.all(1),
                    minScale: 0.98,
                    maxScale: 2.5,
                    child: Container(
                      height: size.height * 0.35,
                      width: size.width,
                      margin: EdgeInsets.symmetric(
                        vertical: size.height * 0.04,
                      ),
                      child: Image.asset(
                        'assets/images/rightAbout.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Form(
                    key: _formKeyRightAbout,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RightAboutOptions(
                          title1Controller: _title1Controller,
                          subtitle1Controller: _subtitle1Controller,
                          boxColor: Colors.red,
                        ),
                        RightAboutOptions(
                          title1Controller: _title2Controller,
                          subtitle1Controller: _subtitle2Controller,
                          boxColor: Colors.green,
                        ),
                        RightAboutOptions(
                          title1Controller: _title3Controller,
                          subtitle1Controller: _subtitle3Controller,
                          boxColor: Colors.amber,
                        ),
                        RightAboutOptions(
                          title1Controller: _title4Controller,
                          subtitle1Controller: _subtitle4Controller,
                          boxColor: Colors.purple,
                        ),
                        SizedBox(height: 20),
                        LoginButton(
                          size: size,
                          text: 'POST',
                          onPressed: postRightAboutUs,
                          fgColor: Colors.white,
                          bgColor: Colors.blue,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postRightAboutUs() async {
    final form = _formKeyRightAbout.currentState;

    try {
      if (form!.validate()) {
        setState(() {
          _isLoading = true;
        });
        Map<String, String> adsDetails = {
          'title1': _title1Controller.text,
          'subtitle1': _subtitle1Controller.text,
          //2
          'title2': _title2Controller.text,
          'subtitle2': _subtitle2Controller.text,
          //3
          'title3': _title3Controller.text,
          'subtitle3': _subtitle3Controller.text,
          //4
          'title4': _title4Controller.text,
          'subtitle4': _subtitle4Controller.text,
        };
        await dataBaseService.rightAboutUs(adsDetails);
        _title1Controller.clear();
        _subtitle1Controller.clear();
        //2
        _title2Controller.clear();
        _subtitle2Controller.clear();
        //3
        _title3Controller.clear();
        _subtitle3Controller.clear();
        //4
        _title4Controller.clear();
        _subtitle4Controller.clear();
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

class RightAboutOptions extends StatelessWidget {
  const RightAboutOptions({
    Key? key,
    required TextEditingController title1Controller,
    required TextEditingController subtitle1Controller,
    required this.boxColor,
  })  : _title1Controller = title1Controller,
        _subtitle1Controller = subtitle1Controller,
        super(key: key);

  final TextEditingController _title1Controller;
  final TextEditingController _subtitle1Controller;
  final Color boxColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: boxColor,
          width: 3,
        ),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 5, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TITLE,  i.e(Building Construction)'),
          SizedBox(
            height: 30,
            child: TextFormField(
              controller: _title1Controller,
              validator: (text) {
                return text!.isEmpty ? 'The Field can not be empty' : null;
              },
            ),
          ),
          SizedBox(height: 10),
          Text('SUBTITLE'),
          TextFormField(
            maxLines: 3,
            controller: _subtitle1Controller,
            validator: (text) {
              return text!.isEmpty ? 'The Field can not be empty' : null;
            },
          ),
        ],
      ),
    );
  }
}
