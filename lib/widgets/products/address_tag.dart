import 'package:flutter/material.dart';

class AdrressTag extends StatelessWidget {
  final String addrress;

  AdrressTag(this.addrress);

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.symmetric(
              vertical: 2.5,
              horizontal: 6.0
              ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0
            ),
            borderRadius: BorderRadius.circular(6.0)
          ),
            child: Text(
            addrress
          ),
          );
  }
}