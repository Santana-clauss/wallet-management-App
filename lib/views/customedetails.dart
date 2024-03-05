// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class custumdetails extends StatelessWidget {
  final imageUrl;
  final String tileTitle;
  final String subTileTitle;
  const custumdetails({
    required this.imageUrl,
    required this.tileTitle,
    required this.subTileTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //icon
        Row(
          children: [
            Container(
              height: 60,
              child: Image.asset(imageUrl),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  tileTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  subTileTitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                )
              ],
            ),
          ],
        ),
        Icon(Icons.arrow_forward_ios),
      ],
    );
  }
}
