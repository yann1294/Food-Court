import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String description;
  ProductPage(this.title, this.imageUrl,this.price,this.description);

  Widget _buildAddressPriceRow(){
    return Row(
              children: <Widget>[
              Expanded(
                child: Text(
            'Taverekere Maruthi Nagar, Bangalore ',
            style: TextStyle(
              fontFamily: 'Oswald',
              color: Colors.grey
            ),
                ),
                ),
                SizedBox(width: 10.0,),
                Text(
                '\$' + price.toString(),
                style: TextStyle(
              fontFamily: 'Oswald',
              color: Colors.grey
            ),
                )
              ],
            );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            ),
        ),
        body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageUrl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TitleDefault(title)
            ),
            _buildAddressPriceRow(),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child:Text(
                description,
                textAlign: TextAlign.center,
                ) ,
            )
            
          ],
        ),
        )
      ),
    );
  }
}
