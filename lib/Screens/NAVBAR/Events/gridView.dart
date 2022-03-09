import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GridViewFormat extends StatefulWidget {
  const GridViewFormat({
    Key? key,
  }) : super(key: key); 

  @override
  _GridViewFormatState createState() => _GridViewFormatState();
}

class _GridViewFormatState extends State<GridViewFormat> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
        // ignore: prefer_const_constructors
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 25.0,
          childAspectRatio: 2 / 2.1,
        ),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return buildGridTile(context);
        });

    ;
  }

  GridTile buildGridTile(BuildContext context) {
    return GridTile(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () async {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          // CachedNetworkImage(imageUrl: null),

          // SizedBox(height: 44),/
        ],
      ),
    );
  }
}
