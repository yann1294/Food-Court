import 'package:flutter/material.dart';

import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final Function updateProduct;
  final Function deleteProduct;
  final List<Map<String, dynamic>> products;

  Widget _buildIconButton(BuildContext context,int index){
  return  IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ProductEditPage(
                            product: products[index],
                            updateProduct: updateProduct,
                            productIndex: index,
                          );
                        },
                      ),
                    );
                  },
                );
  }

  ProductListPage(this.products, this.updateProduct,this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
            onDismissed: (DismissDirection direction){
              if (direction ==DismissDirection.endToStart) {
                //print('Swiped end to start');
                deleteProduct(index);
              }else if(direction ==DismissDirection.startToEnd){
                print('Swiped start to end');
              }else{
                print('Other swiping');
              }
            },
            key: Key(products[index]['title']) ,
            background: Container(color: Colors.red,),
            child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(products[index]['image']),
                ),
                title: Text(products[index]['title']),
                subtitle: Text('\$${products[index]['price'].toString()}'),
                trailing: _buildIconButton(context, index),
              ),
              Divider()
            ],
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
