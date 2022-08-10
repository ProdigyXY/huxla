import 'package:flutter/material.dart';

class AppBubbleDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.circle,
          color: Colors.grey[300],
          size: 5,
        ),
        SizedBox(height: 2.5),
        Icon(
          Icons.circle,
          color: Colors.grey[300],
          size: 5,
        ),
        SizedBox(height: 2.5),
        Icon(
          Icons.circle,
          color: Colors.grey[300],
          size: 5,
        ),
        SizedBox(height: 2.5),
      ],
    );
  }
}
