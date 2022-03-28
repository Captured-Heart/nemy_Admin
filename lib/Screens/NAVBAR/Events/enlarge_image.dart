// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EnlargeScreen extends StatelessWidget {
  const EnlargeScreen({Key? key, required this.appBarTitle, required this.url})
      : super(key: key);
  final String appBarTitle, url;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getImages() async* {
    yield* FirebaseFirestore.instance
        .collection('Catalogue')
        .doc(appBarTitle)
        .collection('Files')
        .snapshots();
  }
}
