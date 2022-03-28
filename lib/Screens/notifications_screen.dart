// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      backgroundColor: Colors.teal[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              Container(
                height: size.height * 0.1,
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.red)),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  'This is a list of the comments made by on the websites',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: getNotifications(context),
                  builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    var nothingDae = !snapshot.hasData;

                    return nothingDae
                        ? Center(
                            child: Text(
                                'No files Available, Kindly check your internet'),
                          )
                        : Padding(
                            padding:
                                EdgeInsets.only(bottom: size.height * 0.20),
                            child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: ((context, index) {
                                  var document = snapshot.data!.docs[index];
                                  return Container(
                                    // height: size.height * 0.1,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 3,
                                    ),
                                    color: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)],
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        NotificationOptions(
                                          document: document,
                                          text: 'First Name: ',
                                          fieldOptions: 'first Name',
                                        ),
                                        NotificationOptions(
                                          document: document,
                                          text: 'Last Name: ',
                                          fieldOptions: 'last Name',
                                        ),
                                        NotificationOptions(
                                          document: document,
                                          text: 'Email: ',
                                          fieldOptions: 'email',
                                        ),
                                        NotificationOptions(
                                          document: document,
                                          text: 'Phone: ',
                                          fieldOptions: 'phone',
                                        ),
                                        NotificationOptions(
                                          document: document,
                                          text: 'Comment/Message: ',
                                          fieldOptions: 'message',
                                        ),
                                      ],
                                    ),
                                  );
                                })),
                          );
                  }),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getNotifications(BuildContext context) async* {
    yield* FirebaseFirestore.instance.collection('Contact Lists').snapshots();
  }
}

class NotificationOptions extends StatelessWidget {
  const NotificationOptions({
    Key? key,
    required this.document,
    required this.text,
    required this.fieldOptions,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> document;
  final String text, fieldOptions;

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(child: Text(document[fieldOptions])),
      ],
    );
  }
}
