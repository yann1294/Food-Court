import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct); 

  _ProductCreatePageState createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleValue= '';
  String _descriptionValue= '';
  double _priceValue= 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
    margin: EdgeInsets.all(10.0),  
    child: ListView(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: 'Product Title',
            
          ),
          autofocus: true,
          onChanged: (String value){
            setState(() {
              _titleValue = value;
            });
          },
        ),
        TextField(

          autofocus: true,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Product Description',
            
          ),
          onChanged: (String value){
            setState(() {
              _descriptionValue = value;
            });
          },
        ),
        TextField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Product Price',
            
          ),
          keyboardType: TextInputType.number,
          onChanged: (String value){
            setState(() {
              _priceValue = double.parse(value);
            });
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        RaisedButton(
          child: Text("Save"),
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          onPressed: (){
            final Map<String,dynamic> product = {
              'title':_titleValue,
              'description':_descriptionValue,
              'price':_priceValue,
              'image':'assets/food.jpg'
              };
            widget.addProduct(product);
            Navigator.pushReplacementNamed(context, '/');
          },
        )
      ],
    )
    ) ;
  }
}
