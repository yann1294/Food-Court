import 'package:flutter/material.dart';
import '../widgets/helpers/ensure_visible.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final  Map<String,dynamic> product;
  final int productIndex;

  ProductEditPage({this.addProduct,this.product,this.updateProduct,this.productIndex}); 

  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
      'title':null,
      'description':null,
      'price':null,
      'image':'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusedNode = FocusNode();
  final _descriptionFocusedNode = FocusNode();
  final _priceFocusedNode = FocusNode();
Widget _buildTitleTextField(){
    return EnsureVisibleWhenFocused(
          focusNode: _titleFocusedNode,
          child: TextFormField(
            focusNode: _titleFocusedNode,
            decoration: InputDecoration(
              labelText: 'Product Title',
            ),
            initialValue: 
            widget.product == null ? '' : widget.product['title'],
            validator: (String value){
              if (value.isEmpty || value.length < 5) {
                return 'Title is required and should be 5+ characters long';
              }
            },
            autofocus: true,
            onSaved: (String value){
              _formData['title'] = value;
                        },
          ),
    );
  }
Widget  _buildDescriptionTextField(){
  return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusedNode,
      child: TextFormField(
            focusNode: _descriptionFocusedNode,
            autofocus: true,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Product Description',
            ),
            initialValue: 
            widget.product == null ? '' : widget.product['description'],
            validator: (String value){
              if (value.isEmpty || value.length < 10) {
                return 'Description is required and should be 10+ characters long';
              }
            },
            onSaved: (String value) {
              _formData['description']= value;
            },
          ),
  );
}
Widget _buildPriceTextField(){
  return EnsureVisibleWhenFocused(
      focusNode: _priceFocusedNode,
      child: TextFormField(
            focusNode: _priceFocusedNode,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Product Price',
            ),
            initialValue: 
            widget.product == null ? '' : widget.product['price'].toString(),
            keyboardType: TextInputType.number,
            validator: (String value){
              if (value.isEmpty || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
                return 'Price is required and should be a number.';
              }
            },
            onSaved: (String value){
            
            _formData['price'] = double.parse(value);
            
            },
          ),
  );
}

Widget _buuildPageContent(BuildContext context){
    final double deviceWidth =MediaQuery.of(context).size.width;
    final double targetWidth =deviceWidth > 768.0 ? 500.0 :deviceWidth * 0.95;
    final double targetPadding =deviceWidth - targetWidth;
  return GestureDetector(
    onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    },
    child:  Container(
    margin: EdgeInsets.all(10.0),  
    child: Form(
      key: _formKey ,
      child: ListView(
      padding: EdgeInsets.symmetric(horizontal: targetPadding/2),
      children: <Widget>[
        _buildTitleTextField(),
        _buildDescriptionTextField(),
        _buildPriceTextField(),
        SizedBox(
          height: 10.0,
        ),
        RaisedButton(
          child: Text("Save"),
          textColor: Colors.white,
          onPressed: _submitForm,
        )
      ],
    ),
    )
    ) 
    );
}

void _submitForm(){
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();
      if(widget.product == null){
        widget.addProduct(_formData);
      }else{
        widget.updateProduct(widget.productIndex,_formData);
      }
            
            Navigator.pushReplacementNamed(context, '/');
          
}
  @override
  Widget build(BuildContext context) {
    final Widget pageContent = _buuildPageContent(context);
    return widget.product == null ? pageContent : Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
      ),
      body: pageContent,
    );
    }
}
