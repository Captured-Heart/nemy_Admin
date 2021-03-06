// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Events/image_screen.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Home/components/dialogs.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Events Screen',
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.teal[50],
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // height: size.height * 0.2,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.red)),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 5),
                child: RichText(
                  text: TextSpan(
                    text:
                        'Below is a list of all the collections you have ever uploaded, ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text:
                            'you can delete any picture in a folder or delete the folder entirely!! ',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade300,
                        ),
                      ),
                      TextSpan(
                        text: 'P.S: ONCE DELETED IT CAN NEVER BE RESTORED!',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder(
                  stream: getCollection(context),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    var nothingDae = !snapshot.hasData;

                    return nothingDae
                        ? Center(
                            heightFactor: size.height * 0.01,
                            child:
                                // RefreshProgressIndicator()
                                Text(
                              'There is no collection yet / Kindly check your Network',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )
                        : Expanded(
                            child: GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              children: snapshot.data!.docs
                                  .map((documents) =>
                                      eventsFolder(context, size, documents))
                                  .toList(),
                            ),
                          );
                  })
              // Container(
            ],
          ),
        ),
      ),
    );
  }

  FocusedMenuHolder eventsFolder(BuildContext context, Size size,
      QueryDocumentSnapshot<Object?> documents) {
    Dialogs dialogs = Dialogs();
    // documents.id;
    Future deleteFolder(context) async {
      // final uid = await authMethods.getCurrentUID();
      final doc =
          FirebaseFirestore.instance.collection('Catalogue').doc(documents.id);

      return await doc.delete();
    }

    return FocusedMenuHolder(
      onPressed: () {},
      menuWidth: size.width * 0.45,
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
          title: Text(
            'Delete',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          onPressed: () {
            dialogs.deleteFolder(
              context,
              () {
                deleteFolder(context);
                Navigator.pop(context);
              },
              'Do You want to Delete This Folder',
            );
          },

          trailingIcon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          // backgroundColor: Colors.redAccent,
        ),
      ],
      child: InkWell(
        onTap: () {
          print(documents.id);

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ImageScreen(
              appBarTitle: documents['folderName'],
            );
          }));
        },
        child: Column(
          children: [
            Icon(
              FontAwesomeIcons.solidFolder,
              size: size.height * 0.1,
              color: Colors.blue[300],
            ),
            Text(
              documents['folderName'],
            )
          ],
        ),
      ),
    );
  }

  final db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getCollection(BuildContext context) async* {
    yield* db.collection('Catalogue').snapshots();
  }
}
