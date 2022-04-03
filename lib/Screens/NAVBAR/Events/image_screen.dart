// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Events/enlarge_image.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key, this.appBarTitle}) : super(key: key);
  final String? appBarTitle;

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  void initState() {
    getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text(widget.appBarTitle!),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: StreamBuilder(
            stream: getImages(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var nothingDae = !snapshot.hasData;
              return nothingDae
                  ? Center(
                      child: CircularProgressIndicator(),
                      // child: Text('There are no pictures available/ Kindly check your Internet connection'),
                    )
                  : GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      children: snapshot.data!.docs
                          .map(
                            (documents) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: InkWell(
                                onTap: () {
                                  // print(documents['url']);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return EnlargeScreen(
                                          url: documents['url'],
                                          appBarTitle: '',
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Image.network(
                                  documents['url'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
            }),
      ),
    );
  }

  Stream<QuerySnapshot> getImages() async* {
    yield* FirebaseFirestore.instance
        .collection('Catalogue')
        .doc(widget.appBarTitle)
        .collection('Files')
        .snapshots();
  }
}
