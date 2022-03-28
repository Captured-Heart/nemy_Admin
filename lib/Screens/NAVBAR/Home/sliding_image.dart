import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nemycraft_admin/Screens/NAVBAR/Home/components/dialogs.dart';

class SlidingImage extends StatefulWidget {
  const SlidingImage({Key? key}) : super(key: key);

  @override
  State<SlidingImage> createState() => _SlidingImageState();
}

class _SlidingImageState extends State<SlidingImage> {
  final Dialogs dialog = Dialogs();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: const Text('Sliding Images Screen'),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: StreamBuilder(
            stream: getCollection(context),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var nothingDae = !snapshot.hasData;

              return nothingDae
                  ? Center(
                      heightFactor: size.height * 0.01,
                      child:
                          // RefreshProgressIndicator()
                          const Text(
                        'There is no collection yet / Kindly check your Network',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var nothingDae = snapshot.hasData;
                        return nothingDae
                            ? eventsFolder(
                                size,
                                snapshot.data!.docs[index],
                              )
                            : const CircularProgressIndicator();
                      },
                      // children: snapshot.data!.docs
                      //     .map((documents) => eventsFolder(size, documents))
                      //     .toList(),
                    );
            }),
      ),
    );
  }

  Widget eventsFolder(Size size, DocumentSnapshot documents) {
    Future delete(context) async {
      final doc =
          FirebaseFirestore.instance.collection('Sliding').doc(documents.id);

      return await doc.delete();
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          documents['url'],
          fit: BoxFit.cover,
        ),
        Positioned(
          right: 1,
          // top: 2,
          child: IconButton(
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                dialog.deleteFolder(context, () {
                  delete(context);
                  Navigator.pop(context);
                });
                // documents.id.
                // _image!.removeAt(index - 1);
              });
            },
            icon: const Icon(
              FontAwesomeIcons.timesCircle,
              size: 30,
            ),
            color: Colors.red,
            // size: 30,
          ),
        ),
      ],
    );
  }

  final db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getCollection(BuildContext context) async* {
    yield* db.collection('Sliding').snapshots();
  }
}
