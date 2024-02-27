// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyFeatures extends StatelessWidget {
  final String imageUrl;
  final String tileTitle;
  final String subTileTitle;
  final VoidCallback onTap;

  const MyFeatures({
    Key? key,
    required this.imageUrl,
    required this.tileTitle,
    required this.subTileTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // icon
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Container(
                    height: 50, 
                    width: 50, 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          spreadRadius: 10,
                          color: Colors.grey
                              .withOpacity(0.3),
                        )
                      ],
                    ),
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 12, 
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        tileTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 12, 
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
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
