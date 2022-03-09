

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListViewFormat extends StatefulWidget {
  const ListViewFormat({
    Key? key,
  }) : super(key: key);

  @override
  _ListViewFormatState createState() => _ListViewFormatState();
}

class _ListViewFormatState extends State<ListViewFormat> {




  @override
  Widget build(BuildContext context) {
    

          return ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return buildListTile(context);
              });
        
  }

  GestureDetector buildListTile(
      BuildContext context) {
   Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){},
      child: ListTile(
        visualDensity: VisualDensity(horizontal: 1, vertical: 1),

        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: size.height * 0.1453,
            width: size.width * 0.15,
            
          ),
        ),

        
        title: Text(
          'folderList',
         
        ),
        subtitle: Row(
          children: [
            Text(
              'folderList',
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            Text(
              'folderList',
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            Text(
              'folderList',
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
           
          },
          child: Icon(FontAwesomeIcons.ellipsisV),
        ),
      ),
    );
  }

}